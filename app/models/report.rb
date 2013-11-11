class Report
  include MongoMapper::Document
  key :account_id, ObjectId, :required => true
  key :report_id, ObjectId, :required => true
  key :title, String, :required => true
  key :description, String
  key :options, Hash
  
  belongs_to :account
  after_validation :query_entries
  
  def query_entries
    @entries = []
    
  end
end
