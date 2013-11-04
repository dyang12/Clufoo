class User
  include MongoMapper::Document
  attr_reader :password
  
  key :username, String, :required => true, :unique => true
  key :password_digest, String, :required => true
  key :session_token, String, :required => true
  
  timestamps!
  
  validates_length_of :password, :minimum => 6, :allow_nil => true
  
  before_validation :ensure_session_token
  
  many :forms
  
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
  
  private
  def ensure_session_token
      self.session_token ||= self.class.generate_session_token
  end
end