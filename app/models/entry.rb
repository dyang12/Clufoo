class Entry
  include MongoMapper::Document
  key :account_id, ObjectId, :required => true
  key :form_id, ObjectId, :required => true
  key :response_data, Hash
  
  timestamps!
  
  attr_accessible :account_id, :form_id, :response_data
  
  validate :response_data_validation
  
  many :comments
  belongs_to :form
  
  before_validation :get_form

  
  def response_data_validation
    form.fields.each do |field|
      attribute = response_data[field.id.to_s]
      
      required_validation(attribute, field.label) if field.required
      uniqueness_validation(attribute, field) if field.uniqueness
    end
  end
  
  def required_validation(val, label)
    if val.nil? || val.length == 0
      errors[label.to_sym] << "label cannot be blank."
    end
  end
  
  def uniqueness_validation(val, field)
    values_taken = form.entries.map do |entry|
      entry.response_data[field.id.to_s] if id != entry.id
    end

    if values_taken.include?(val)
      errors[field.label.to_sym] << "label must be unique."
    end
  end
  
  def method_missing(attr_id, *args)
    if form && form.has_field_id?(attr_id)
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
