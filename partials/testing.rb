def setup_testing
  puts "🧪  Configuring RSpec..."
  generate 'rspec:install'
  
  # Configure .rspec output format
  append_to_file '.rspec', '--format documentation'
  
  # Configure FactoryBot syntax
  inject_into_file 'spec/rails_helper.rb', after: "RSpec.configure do |config|\n" do
    "  config.include FactoryBot::Syntax::Methods\n"
  end

  # Configure Generators in application.rb
  inject_into_file 'config/application.rb', after: "class Application < Rails::Application\n" do
    <<-RUBY

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        request_specs: true
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
    RUBY
  end
end