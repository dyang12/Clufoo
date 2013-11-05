class Field
  include MongoMapper::EmbeddedDocument
  
  key :label, String, :required => true
  key :type, String, :required => true
  key :required, String
  key :uniqueness, String
  key :options, Array
  
  attr_accessible :label, :type, :required, :uniqueness, :options
  
  timestamps!
end
