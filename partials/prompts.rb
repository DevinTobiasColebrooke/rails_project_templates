def setup_prompt_management
  puts "🧠  Setting up Prompt Management..."

  create_file "config/prompts.yml", <<~YAML
    system:
      default_assistant: "You are a helpful assistant."
      data_analyst: "You are an expert data analyst. Output JSON only."
    
    user:
      summarize: "Please summarize the following text: %{text}"
  YAML

  create_file "app/models/prompt.rb", <<~RUBY
    class Prompt
      # Simple wrapper to fetch prompts
      # Usage: Prompt.get('system.data_analyst')
      def self.get(key, **args)
        prompts = YAML.load_file(Rails.root.join('config/prompts.yml'))
        template = prompts.dig(*key.split('.'))
        
        return "Prompt key '\#{key}' not found" unless template
        
        if args.any?
          template % args
        else
          template
        end
      rescue KeyError
        "Missing arguments for prompt '\#{key}'"
      end
    end
  RUBY
end