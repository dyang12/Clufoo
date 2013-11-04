class Field
  include MongoMapper::EmbeddedDocument
  
  key :question, String, :required => true
  key :type, String, :required => true
  key :required, Boolean
  key :uniqueness, Boolean
  key :options, Array
  
  timestamps!
end
