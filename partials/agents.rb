# Load all individual agent definitions
load_partial 'agents/api_agent'
load_partial 'agents/auth_agent'
load_partial 'agents/caching_agent'
load_partial 'agents/concerns_agent'
load_partial 'agents/crud_agent'
load_partial 'agents/events_agent'
load_partial 'agents/implement_agent'
load_partial 'agents/jobs_agent'
load_partial 'agents/mailer_agent'
load_partial 'agents/migration_agent'
load_partial 'agents/model_agent'
load_partial 'agents/multi_tenant_agent'
load_partial 'agents/refactoring_agent'
load_partial 'agents/review_agent'
load_partial 'agents/state_records_agent'
load_partial 'agents/stimulus_agent'
load_partial 'agents/test_agent'
load_partial 'agents/turbo_agent'
load_partial 'agents/product_strategist_agent'
load_partial 'agents/requirements_specialist_agent'
load_partial 'agents/system_architect_agent'
load_partial 'agents/user_proxy_agent'
load_partial 'agents/sre_agent'

def setup_agents
  puts '🤖 Setting up AI Agents...'

  empty_directory '.opencode/agents'

  create_api_agent_agent
  create_auth_agent_agent
  create_caching_agent_agent
  create_concerns_agent_agent
  create_crud_agent_agent
  create_events_agent_agent
  create_implement_agent_agent
  create_jobs_agent_agent
  create_mailer_agent_agent
  create_migration_agent_agent
  create_model_agent_agent
  create_multi_tenant_agent_agent
  create_refactoring_agent_agent
  create_review_agent_agent
  create_state_records_agent_agent
  create_stimulus_agent_agent
  create_test_agent_agent
  create_turbo_agent_agent
  create_product_strategist_agent_agent
  create_requirements_specialist_agent_agent
  create_system_architect_agent_agent
  create_user_proxy_agent_agent
  create_sre_agent_agent
end
