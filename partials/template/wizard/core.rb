# 1. Configuration Wizard
puts "\n🚀 Rails 8 Master Template Wizard"
puts "========================================================"

# Helper to check ENV first, then ask
def fetch_config(prompt, env_var)
  if ENV[env_var].present?
    puts "    🔑  Found value for #{env_var} from script."
    ENV[env_var]
  else
    ask(prompt)
  end
end

# Detect API Mode
@api_only = options[:api]