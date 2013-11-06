module FormsHelper
  def create_tag(field_id)
    "entry[" + field_id + "]"
  end
  
  def get_selections(field)
    selections = []
    
    field.choices.each do |choice|
      selections << [choice, choice]
    end
    
    selections
  end
  
  def radio_tag(field_id, val)
    "entry_" + field_id + "_" + val.downcase
  end
  
  def checkbox_tag(field_id, val)
    field_id.to_s + "[" + val.downcase + "]"
  end
  
  def checkbox_id(field_id, val)
    field_id.to_s + "_" + val.downcase
  end
  
  def checkbox_name(field_id)
    "entry[" + field_id + "][]"
  end
end
