class Entry
  include MongoMapper::Document
  key :user_id, ObjectId
  key :form_id, ObjectId
  key :response_data, Hash
  
  timestamps!
  
  attr_accessible :user_id, :form_id, :response_data
  
  belongs_to :form
  
  def get_form
     return User.find(user_id).forms.find(form_id) if user_id
     nil
  end
  
  def method_missing(attr_id, *args)
    if get_form && get_form.has_field_id?(attr_id)
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
