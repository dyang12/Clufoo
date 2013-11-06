class FormsController < ApplicationController
  def show
    @form = current_user.forms.find(params[:id])
    render :show
  end
  
  def display
    @form = current_user.forms.find(params[:id])
    @entry = Entry.new
    render :display
  end
  
  def new
    @form = Form.new
    render :new
  end
  
  def create
    @form = Form.new(params[:form])
    
    if @form.valid?
      forms = current_user.forms
      forms.push(@form)
      current_user.update_attributes(:forms => forms)
      
      redirect_to form_url(@form.id)
    else
      flash.now[:errors] = @form.errors.full_messages
      render :new
    end
  end
  
  def edit
    @form = current_user.forms.find(params[:id])
    render :edit
  end
  
  def update
    @form = current_user.forms.find(params[:id])
    
    if @form.update_attributes(params[:form])
      redirect_to form_url(@form.id)
    else
      flash.now[:errors] = @form.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @form = current_user.forms.find(params[:id])
    forms = current_user.forms
    forms.delete(@form)
    
    current_user.update_attributes(:forms => forms)
    
    redirect_to user_url(current_user.id)
  end
end
