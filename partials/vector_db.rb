# Load split files from the vector_db directory
apply File.join(__dir__, 'vector_db', 'database.rb')
apply File.join(__dir__, 'vector_db', 'concerns.rb')
apply File.join(__dir__, 'vector_db', 'model.rb')

def setup_vector_db
  setup_vector_db_database
  setup_vector_db_concerns
  setup_vector_db_model
end