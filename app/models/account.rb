class Account
  include MongoMapper::Document

  
  many :forms
  many :users
end
