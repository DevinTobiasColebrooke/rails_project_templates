def setup_recon
  puts "🕵️‍♂️  Configuring Recon Deep Research Agent..."

  # Load sub-modules
  apply File.join(__dir__, 'recon', 'clients.rb')
  apply File.join(__dir__, 'recon', 'models.rb')
  apply File.join(__dir__, 'recon', 'core_services.rb')
  
  # Load Agent Components (Context & Researcher) before the Orchestrator
  apply File.join(__dir__, 'recon', 'agent', 'context.rb')
  apply File.join(__dir__, 'recon', 'agent', 'researcher.rb')
  apply File.join(__dir__, 'recon', 'agent.rb')

  apply File.join(__dir__, 'recon', 'tools.rb')
  apply File.join(__dir__, 'recon', 'controller.rb')
  apply File.join(__dir__, 'recon', 'launcher.rb')

  # Execute setup methods
  setup_recon_clients
  setup_recon_models
  setup_recon_core_services
  setup_recon_agent
  setup_recon_tools
  setup_recon_controller
  setup_recon_launcher
end