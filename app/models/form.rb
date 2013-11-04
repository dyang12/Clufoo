class Form
  include MongoMapper::EmbeddedDocument
  
  key :title, String, :required => true
  key :description, String
  
  timestamps!
  
  many :fields
  
end