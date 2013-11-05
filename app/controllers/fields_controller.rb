class FieldsController < ApplicationController
  def new
    render :new
  end

  def create
    render :json => params
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end

end
