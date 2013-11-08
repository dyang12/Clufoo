class Account
  include MongoMapper::Document
  key :creator_id, ObjectId
  
  many :forms
  many :users
  
  def is_creator?(user)
    creator_id == user.id
  end
end
