class Entry
  include MongoMapper::Document
  key :form_id, ObjectId
  key :response_data, Hash
  
  timestamps!
  
  attr_accessible :form_id, :response_data
  
  belongs_to :form
  
  def method_missing(*args)
    if this.form.has_field(args[0])
      
    else
      super
    end
  end
end
