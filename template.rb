# Helper to load partials
def load_partial(name)
  apply File.join(__dir__, 'partials', "#{name}.rb")
end

# 1. Configuration Wizard
load_partial 'template/wizard'

# 2. Load Partials 
load_partial 'template/manifest'

# 3. Execute Setup 
load_partial 'template/lifecycle'