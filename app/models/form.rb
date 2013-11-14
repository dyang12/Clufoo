class Form
  include MongoMapper::Document
  
  key :account_id, ObjectId, :required => true
  key :title, String, :required => true
  key :description, String
  key :forward_email, String
  
  timestamps!
  
  attr_accessible :title, :description, :account_id, :forward_email, :fields
  
  before_save :set_num_entries
  
  many :fields
  many :entries
  belongs_to :account
  
  def has_field_id?(field_id)
    self.fields.each  { |field| return true if field.id == field_id }
    
    false
  end
end