class Field
  include MongoMapper::EmbeddedDocument
  
  key :label, String, :required => true
  key :type, String, :required => true
  key :required, String
  key :uniqueness, String
  key :options, Array
  
  timestamps!
  
  attr_accessible :label, :type, :required, :uniqueness, :options
  
  before_validation :generate_options
  
  private
  def generate_options
    if self.type == "radio" || "checkbox"
      default_options = []
      
      
      
      self.options = default_options
    end
  end
end
