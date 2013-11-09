class Report
  include MongoMapper::Document
  key :account_id, ObjectId, :required => true
  key :report_id, ObjectId, :required => true
  key :title, String, :required => true
  
  belongs_to :account
end
