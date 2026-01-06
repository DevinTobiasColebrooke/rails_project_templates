def setup_recon_agent
  create_file "app/services/recon/shared_context.rb", <<~RUBY
    module Recon
      class SharedContext
        # Cache HTML content for 24 hours to be ethical
        TTL = 24.hours

        def initialize(org_name)
          @org_name = org_name
          @local_memory = {}
        end

        def cache_page(url, content)
          return if content.blank?
          @local_memory[url] = content
          Rails.cache.write(cache_key(url), content, expires_in: TTL)
        end

        def get_page(url)
          @local_memory[url] || Rails.cache.read(cache_key(url))
        end

        private

        def cache_key(url)
          "recon_html/\#{Digest::MD5.hexdigest(url)}"
        end
      end
    end
  RUBY

  create_file "app/services/recon/autonomous_orchestrator.rb", <<~RUBY
    module Recon
      class AutonomousOrchestrator
        # Max turns to prevent infinite loops and cost
        MAX_TURNS = 8

        # Changed: Accept 'history' keyword argument
        def initialize(goal, history: [])
          @goal = goal
          @history = history
          @llm = LocalLlmClient.new
          @logs = []

          # Load available tools using global scope ::Tools
          # We explicitly list them to ensure they are loaded and ordered correctly
          @tools = [
            ::Tools::GoogleSearchTool,
            ::Tools::SearxngSearchTool,
            ::Tools::VisitPageTool
          ]
          @tool_definitions = @tools.map(&:definition)
        end

        def call
          log "Starting deep research for goal: \#{@goal}"

          # 1. Start with System Prompt
          messages = [ { role: "system", content: system_prompt } ]

          # 2. Inject Chat History (if any)
          # We map string keys to symbols or keep as is, ensuring format is correct for the LLM client
          if @history.present?
            messages += @history.map do |msg|
              {
                role: msg["role"] || msg[:role],
                content: msg["content"] || msg[:content]
              }
            end
          end

          # 3. Add Current Request
          messages << { role: "user", content: "Current Task: \#{@goal}" }

          MAX_TURNS.times do |turn|
            log "Turn \#{turn + 1}: Thinking..."

            response = @llm.chat_with_tools(messages: messages, tools: @tool_definitions)

            if response[:tool_calls]
              log "Agent decided to call tools: \#{response[:tool_calls].map { |t| t.dig('function', 'name') }.join(', ')}"

              # Add the assistant's "intent" to call a tool to history
              messages << { role: "assistant", content: nil, tool_calls: response[:tool_calls] }

              response[:tool_calls].each do |tool_call|
                function_name = tool_call.dig("function", "name")
                arguments = JSON.parse(tool_call.dig("function", "arguments"))
                tool_call_id = tool_call["id"]

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
            tool_class.new.call(args)
          else
            "Error: Tool \#{name} not found."
          end
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

            When you have the final answer, respond with the text of the report directly (no tool calls).
          PROMPT
        end

        def log(msg)
          @logs << { time: Time.current, msg: msg }
          Rails.logger.info "[ReconAgent] \#{msg}"
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
    end
  RUBY
end