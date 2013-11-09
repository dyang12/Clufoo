class Account
  include MongoMapper::Document
  key :creator_id, ObjectId, :required => true
  
  many :forms
  many :users
  many :reports
  
  def is_creator?(user_id)
    creator_id == user_id
  end
end
