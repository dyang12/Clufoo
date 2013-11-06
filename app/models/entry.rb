class Entry
  include MongoMapper::Document
  key :form_id, ObjectId
  key :response_data, Hash
  
  timestamps!
  
  attr_accessible :form_id, :response_data
  
  belongs_to :form
end
