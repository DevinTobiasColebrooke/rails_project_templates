# Load specific concerns
apply File.join(__dir__, 'concerns', 'embeddable.rb')
apply File.join(__dir__, 'concerns', 'ingestable.rb')

def setup_vector_db_concerns
  setup_vector_embeddable
  setup_document_ingestable
end