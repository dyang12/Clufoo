class FormsController < ApplicationController
  def show
    @form = current_user.forms.find(params[:id])
    render :show
  end
  
  def new
    @form = Form.new
    render :new
  end
  
  def create
    @form = Form.new(params[:form])
    
    #doesnt work
    if current_user.update_attributes(:forms =>[@form])
      redirect_to form_url(@form)
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
    #???
  end
  
  def destroy
    #???
  end
end
