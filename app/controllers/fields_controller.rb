class FieldsController < ApplicationController
  def new
    @form = current_user.forms.find(params[:form_id])
    @field = Field.new
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
    @form = current_user.forms.find(params[:form_id])
    @field = @form.fields.find(params[:id])
    render :edit
  end
  
  def update
    @form = current_user.forms.find(params[:form_id])
    @field = @form.fields.find(params[:id])
    
    if params[:field][:type] == "text_field" || params[:field][:type] == "text_area"
      params[:field][:choices] = nil
    elsif params[:choice]
      choices = []
    
      params[:choice].each do |key, val|
        choices << val unless val == ""
      end

      params[:field][:choices] = choices
    end
    
    unless params[:field][:required]
      @field.required = nil
    end
    unless params[:field][:uniqueness]
      @field.uniqueness = nil
    end
    
    if @field.update_attributes(params[:field])
      redirect_to form_url(@form.id)
    else
      flash.now[:errors] = @field.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @form = current_user.forms.find(params[:form_id])
    @field = @form.fields.find(params[:id])
    fields = @form.fields
    fields.delete(@field)
    
    @form.update_attributes(:fields => fields)
    
    redirect_to form_url(@form.id)
  end

end
