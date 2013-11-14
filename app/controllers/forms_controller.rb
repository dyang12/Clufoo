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
    @form = Form.new(params[:form])
    
    if @form.save
      redirect_to forms_url(current_account)
    else
      flash.now[:errors] = @form.errors.full_messages
      render :new
    end
  end
  
  def edit
    @form = Form.find(params[:id])
    render :edit
  end
  
  def update
    @form = Form.find(params[:id])
    
    if @form.update_attributes(params[:form])
      render :show
    else
      flash.now[:errors] = @form.errors.full_messages
      render :edit
    end
  end
  
  def duplicate
    old_form = Form.find(params[:id])
    fields = old_form.fields.map {|field| Field.dup(field) }
    
    attributes = old_form.attributes
    attributes.delete("_id")
    attributes[:fields] = fields
    
    Form.create(attributes)
      
    redirect_to forms_url(current_account)
  end
  
  def destroy
    @form = Form.find(params[:id])
    @form.destroy
    
    redirect_to forms_url(current_account)
  end
end
