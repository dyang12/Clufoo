class Comment
  include MongoMapper::EmbeddedDocument

  key :comment, String, :required => true
  
  timestamps!
  
  attr_accessible :comment

end
