class Field
  include MongoMapper::EmbeddedDocument
  
  key :label, String, :required => true
  key :type, String, :required => true
  key :required, String
  key :uniqueness, String
  key :choices, Array
  
  timestamps!
  
  attr_accessible :label, :type, :required, :uniqueness, :choices
  
  before_validation :generate_choices
  
  def display_type
    case self.type
    when "text_field"
      return "Single Line Text"
    when "text_area"
      return "Paragraph Text"
    when "check_box"
      return "Checkbox"
    when "select"
      return "Dropdown"
    when "radio_button"
      return "Multiple Choice"
    else
      return ""
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
  
  def isNotText
    self.type == "radio_button" || self.type == "check_box" || self.type == "select"
  end
  
  def self.dup(field)
    attributes = field.attributes
    attributes.delete("_id")
    Field.new(attributes)
  end
  
  private
  def generate_choices
    if self.choices.empty? && self.isNotText
      self.choices = ["First Choice", "Second Choice", "Third Choice"]
    end
  end
end
