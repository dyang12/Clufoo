class Form
  include MongoMapper::EmbeddedDocument
  
  key :title, String, :required => true
  key :description, String
  
  timestamps!
  
  attr_accessible :title, :description, :fields
  
  many :fields
  
end