class FormsController < ApplicationController
  before_filter :require_current_user!
  
  def index
    @forms = current_account.forms
    render :index
  end
  
  def show
    @form = current_account.forms.find(params[:id])
    render :show
  end
  
  def new
    @form = Form.new
    render :new
  end
  
  def create
    @form = Form.new(params[:form])
    
    if @form.valid?
      forms = current_account.forms
      forms.push(@form)
      current_account.update_attributes(:forms => forms)
      
      redirect_to forms_url(current_account)
    else
      flash.now[:errors] = @form.errors.full_messages
      render :new
    end
  end
  
  def edit
    @form = current_account.forms.find(params[:id])
    render :edit
  end
  
  def update
    @form = current_account.forms.find(params[:id])
    
    if @form.update_attributes(params[:form])
      render :show
    else
      flash.now[:errors] = @form.errors.full_messages
      render :edit
    end
  end
  
  def duplicate
    old_form = current_account.forms.find(params[:id])
    fields = old_form.fields.map {|field| Field.dup(field) }
    
    attributes = old_form.attributes
    attributes.delete("_id")
    attributes[:fields] = fields
    
    @form = Form.new(attributes)
    
    forms = current_account.forms
    forms.push(@form)
    current_account.update_attributes(:forms => forms)
      
    redirect_to forms_url(current_account)
  end
  
  def destroy
    @form = current_account.forms.find(params[:id])
    forms = current_account.forms
    forms.delete(@form)
    
    current_account.update_attributes(:forms => forms)
    
    redirect_to forms_url(current_account)
  end
end
