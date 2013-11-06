class Form
  include MongoMapper::EmbeddedDocument
  
  key :title, String, :required => true
  key :description, String
  
  timestamps!
  
  attr_accessible :title, :description, :fields
  
  many :fields
  many :entries
  
  def has_field_id?(field_id)
    self.fields.each  { |field| return true if field.id == field_id }
    
    false
  end
end