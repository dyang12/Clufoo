module FormsHelper
  def create_tag(field_id)
    "entry[" + field_id + "]"
  end
end
