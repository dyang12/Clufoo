class FormsController < ApplicationController
  before_filter :require_current_user!
  
  def index
    @forms = current_account.forms
    render :index
  end
  
  def show
    @form = Form.find(params[:id])
    render :show
  end
  
  def new
    render :new
  end
  
  def create
    params[:form][:account_id] = current_account.id
    fields = []
    
    if params[:fields]
      params[:fields].each do |key, val|
        field = Field.new(val[val.keys[0]])
        fields << field
      end
    end
    
    params[:form][:fields] = fields
    @form = Form.new(params[:form])
    
    if @form.save
      render :json => {}
    else
      errors = {}
      @form.errors.delete(:fields)
      errors[:form] = @form.errors.messages
      
      @form.fields.each_with_index do |field, i|
        errors[("field-" + i.to_s).to_sym] = field.errors.messages
      end
      
      p errors
      
      render :json => errors
    end
  end
  
  def edit
    @form = Form.find(params[:id])
    render :edit
  end
  
  def update
    @form = Form.find(params[:id])
    fields = []
    
    if params[:fields]
      params[:fields].each do |key, val|
        field = Field.new(val[val.keys[0]])
        fields << field
      end
    end
    
    params[:form][:fields] = fields
    
    if @form.update_attributes(params[:form])
      render :json => {}
    else
      render :json => @form.errors.messages
    end
  end
  
  def duplicate
    old_form = Form.find(params[:id])
    fields = old_form.fields.map {|field| Field.dup(field) }
    
    attributes = old_form.attributes
    attributes.delete("_id")
    attributes[:fields] = fields
    
    Form.create(attributes)
      
    redirect_to forms_url
  end
  
  def destroy
    @form = Form.find(params[:id])
    @form.destroy
    
    redirect_to forms_url
  end
end
