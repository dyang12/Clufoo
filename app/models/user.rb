class User
  include MongoMapper::Document
  attr_reader :password
  
  key :account_id, ObjectId, :required => true
  key :username, String, :required => true, :unique => true
  key :email, String, :required => true, :unique => true
  key :password_digest, String, :required => true
  key :session_token, String, :required => true
  key :admin, String
  
  timestamps!
  
  attr_accessible :account_id, :username, :password, :email, :admin, :forms
  
  validates_length_of :password, :minimum => 6, :allow_nil => true
  
  before_validation :ensure_session_token
  
  belongs_to :account
  
  def self.find_by_credentials(username, password)
     user = User.find_by_username(username)

     (user && user.is_password?(password)) ? user : nil
  end
  
  def password=(pass)
     @password = pass
     self.password_digest = BCrypt::Password.create(pass)
  end

  def is_password?(pass)
     BCrypt::Password.new(self.password_digest).is_password?(pass)
  end
  
  def self.generate_session_token
     SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
     self.session_token = self.class.generate_session_token
     self.save!
  end
  
  def user_type
    if account.is_creator?(id)
      return "Account creator"
    elsif admin
      return "Admin"
    end
    
    return "User"
  end
  
  private
  def ensure_session_token
      self.session_token ||= self.class.generate_session_token
  end
end