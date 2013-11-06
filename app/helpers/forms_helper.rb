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
    create_tag(field_id) + "_" + val
  end
  
  def checkbox_tag(field_id, val)
    create_tag(field_id) + "[" + val + "]"
  end
end
