def setup_recon_researcher
  create_file "app/models/research_agent.rb", <<~RUBY
    class ResearchAgent
      include ActiveModel::Model

      # Max turns to prevent infinite loops and cost
      MAX_TURNS = 8

      attr_accessor :goal, :history

      def initialize(goal:, history: [])
        @goal = goal
        @history = history
        @llm = LlmClient.new
        @logs = []

        # Load available tool strategies
        @tools = [
          Tools::GoogleSearch,
          Tools::SearxngSearch,
          Tools::VisitPage
        ]
        @tool_definitions = @tools.map(&:definition)
      end

      def perform
        log "Starting deep research for goal: \#{@goal}"

        # 1. Start with System Prompt
        messages = [ { role: "system", content: system_prompt } ]

        # 2. Inject Chat History
        if @history.present?
          messages += @history.map do |msg|
            {
              role: msg["role"] || msg[:role],
              content: msg["content"] || msg[:content]
            }
          end
        end

        # 3. Add Current Request
        messages << { role: "user", content: "Current Task: \#{@goal}\\n\\nIMPORTANT: Provide a detailed report and cite your sources (URLs) for every fact." }

        MAX_TURNS.times do |turn|
          log "Turn \#{turn + 1}: Thinking..."

          response = @llm.chat_with_tools(messages: messages, tools: @tool_definitions)
          
          # Helper to normalize tool calls from either API structure or text hallucination
          tool_calls = response[:tool_calls] || extract_json_tools(response[:content])

          if tool_calls.present?
            log "Agent decided to call tools: \#{tool_calls.map { |t| t.dig('function', 'name') }.join(', ')}"

            # Save assistant's thought process
            messages << { role: "assistant", content: response[:content], tool_calls: (response[:tool_calls] if response[:tool_calls]) }

            tool_calls.each do |tool_call|
              function_name = tool_call.dig("function", "name")
              # Parse arguments if they are a string (API) or already a hash (Extraction)
              raw_args = tool_call.dig("function", "arguments")
              arguments = raw_args.is_a?(String) ? JSON.parse(raw_args) : raw_args
              
              tool_call_id = tool_call["id"] || "call_\#{SecureRandom.hex(4)}"

              result = execute_tool(function_name, arguments)
              log "Tool \#{function_name} output length: \#{result.to_s.length} chars"

              # Return tool result to LLM
              messages << {
                role: "tool",
                tool_call_id: tool_call_id,
                name: function_name,
                content: result.to_s
              }
            end
          else
            # Final Answer
            final_answer = response[:content]
            log "Research Complete. Final Answer generated."

            persist_log(final_answer)
            return { status: "success", report: final_answer, logs: @logs }
          end
        end

        # If we run out of turns
        fail_msg = "Research inconclusive after \#{MAX_TURNS} turns."
        persist_log(fail_msg)
        { status: "timeout", report: fail_msg, logs: @logs }
      rescue => e
        log "Critical Error: \#{e.message}"
        Rails.logger.error e.backtrace.join("\\n")
        { status: "error", error: e.message, logs: @logs }
      end

      private

      def execute_tool(name, args)
        tool_class = @tools.find { |t| t.tool_name == name }
        if tool_class
          tool_class.new.run(args)
        else
          "Error: Tool \#{name} not found."
        end
      end

      # Fallback: Extract JSON tool calls from text if the model outputs them directly
      def extract_json_tools(text)
        return nil if text.blank?

        # Look for markdown code blocks containing JSON first
        json_candidates = text.scan(/```json\\s*(\\{.*?\\})\\s*```/m).flatten
        
        # If no code blocks, look for raw JSON-like structures matching our tool schema
        if json_candidates.empty?
          # Regex looks for {"name": "...", "parameters": {...}}
          json_candidates = text.scan(/(\\{[\\s\\n]*"name"[\\s\\n]*:[\\s\\n]*"[a-zA-Z0-9_]+"[\\s\\n]*,[\\s\\n]*"parameters"[\\s\\n]*:[\\s\\n]*\\{.*?\\})/m).flatten
        end

        return nil if json_candidates.empty?

        json_candidates.map do |json_str|
          try_parse_tool(json_str)
        end.compact
      end

      def try_parse_tool(json_str)
        data = JSON.parse(json_str)
        return nil unless data["name"] && data["parameters"]

        # Normalize to OpenAI structure
        {
          "id" => "call_\#{SecureRandom.hex(4)}",
          "type" => "function",
          "function" => {
            "name" => data["name"],
            "arguments" => data["parameters"] # Pass as hash, handled in loop
          }
        }
      rescue JSON::ParserError
        nil
      end

      def system_prompt
        <<~PROMPT
          You are a Deep Research Agent. Your goal is to gather accurate, comprehensive information to answer the user's request.

          You have access to the following tools:
          1. google_search: Best for official entities, news, and finding specific websites.
          2. searxng_search: Best for broad queries, alternative sources, or when Google fails.
          3. visit_page: ESSENTIAL. After searching, you MUST visit promising URLs to read their actual content. Do not hallucinate content.

          Workflow:
          1. Plan your research.
          2. Search for information.
          3. Visit relevant pages to verify details.
          4. Synthesize a final report.

          CITATION REQUIREMENT:
          - You MUST cite your sources.
          - Every fact derived from a tool output must be followed by the source URL.
          - Format: "Fact statement [Source Name](url)".
          - At the end of your response, include a "## Sources" section listing all URLs used.

          IMPORTANT:
          If you need to use a tool, output the tool call in JSON format matching the schema. 
          Do not describe the plan without executing the tool.
          If you have the answer, respond with the text of the report directly.
        PROMPT
      end

      def log(msg)
        @logs << { time: Time.current, msg: msg }
        Rails.logger.info "[ResearchAgent] \#{msg}"
      end

      def persist_log(result)
        ReconnaissanceLog.create(
          query: @goal.truncate(250),
          report: result,
          logs: @logs,
          search_method: "deep_research_v2"
        )
      rescue => e
        Rails.logger.error "Failed to save logs: \#{e.message}"
      end
    end
  RUBY
end