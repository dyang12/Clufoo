class Entry
  include MongoMapper::Document
  key :form_id, ObjectId

  belongs_to :form
end
