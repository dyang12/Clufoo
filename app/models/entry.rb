class Entry
  include MongoMapper::Document
  key :user_id, ObjectId, :required
  key :form_id, ObjectId, :required
  key :response_data, Hash
  
  timestamps!
  
  attr_accessible :user_id, :form_id, :response_data
  
  validate :response_data_validation
  
  belongs_to :form
  
  before_validation :get_form
  
  def get_form
     @form = User.find(user_id).forms.find(form_id)
  end
  
  def response_data_validation
    response_data.each do |key, val|
      field = @form.fields.find(key)
      
      required_validation(val, field.label) if field.required
      uniqueness_validation(val, field) if field.uniqueness
    end
  end
  
  def required_validation(val, label)
    if val.length == 0
      errors[label.to_sym] << "label cannot be blank."
    end
  end
  
  def uniqueness_validation(val, field)
    values_taken = @form.entries.map { |entry| entry.response_data[field.id.to_s] }

    if values_taken.include?(val)
      errors[field.label.to_sym] << "label must be unique."
    end
  end
  
  def method_missing(attr_id, *args)
    if @form && @form.has_field_id?(attr_id)
      super
    else
      if args.length == 0
        return self.response_data[attr_id]
      else
        self.response_data[attr_id] = args[0]
      end
    end
  end
end
