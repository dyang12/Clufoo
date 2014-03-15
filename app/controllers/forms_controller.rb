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
    
    params[:fields].each do |key, val|
      field = Field.new(val[val.keys[0]])
      fields << field
    end
    
    params[:form][:fields] = fields
    @form.new(params[:form])
    
    render :json => {}
  end
  
  def edit
    @form = Form.find(params[:id])
    render :edit
  end
  
  def update
    @form = Form.find(params[:id])
    fields = []
    
    params[:fields].each do |key, val|
      field = Field.new(val[val.keys[0]])
      fields << field
    end
    
    @form.update_attributes(:fields => fields)
    @form.update_attributes(params[:form])
    
    render :json => {}
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
