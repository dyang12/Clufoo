class FieldsController < ApplicationController
  def new
    @form = current_user.forms.find(params[:form_id])
    render :new
  end

  def create
    @field = Field.new(params[:field])
    @form = current_user.forms.find(params[:form_id])
    
    if @field.valid?
      fields = @form.fields
      fields.push(@field)
      @form.update_attributes(:fields => fields)
      
      redirect_to form_url(@form.id)
    else
      flash.now[:errors] = @field.errors.full_messages
      render :new
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end

end
