class Field
  include MongoMapper::EmbeddedDocument
  
  key :label, String, :required => true
  key :type, String, :required => true
  key :required, String
  key :uniqueness, String
  key :choices, Array
  
  timestamps!
  
  attr_accessible :label, :type, :required, :uniqueness, :options
  
  # before_validation :generate_choices
  
  def display_type
    if self.type == "text"
      return "Single Line Text"
    elsif self.type == "textarea"
      return "Paragraph Text"
    elsif self.type == "checkbox"
      return "Checkbox"
    elsif self.type == "select"
      return "Dropdown"
    else
      return "Multiple Choice"
    end
  end
  
  def display_options
    opt_string = ""
    
    if self.required
      opt_string += "Required, "
    end
    
    if self.uniqueness
      opt_string += "No duplicates, "
    end
    
    opt_string.chop.chop
  end
  
  private
  # def generate_choices
#     if self.type == "radio" || "checkbox"
#       default_choices = []
#       
#       
#       
#       self.choices = default_choices
#     end
#   end
end
