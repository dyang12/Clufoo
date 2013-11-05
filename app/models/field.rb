class Field
  include MongoMapper::EmbeddedDocument
  
  key :label, String, :required => true
  key :type, String, :required => true
  key :required, String
  key :uniqueness, String
  key :choices, Array
  
  timestamps!
  
  attr_accessible :label, :type, :required, :uniqueness, :options
  
  before_validation :generate_choices
  
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
    opts = []
    
    opts << "Required" if self.required
    opts << "No Duplicates" if self.uniqueness
    
    opts.join(", ")
  end
  
  def display_choices
    self.choices.join(", ")
  end
  
  private
  def generate_choices
    if self.type == "radio" || self.type == "checkbox"
      self.choices = ["First Choice", "Second Choice", "Third Choice"]
    end
  end
end
