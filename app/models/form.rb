class Form
  include MongoMapper::EmbeddedDocument
  
  key :title, String, :required => true
  key :description, String
  
  attr_accessible :title, :description
  
  timestamps!
  
  many :fields
  
end