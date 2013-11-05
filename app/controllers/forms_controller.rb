class FormsController < ApplicationController
  def show
    @form = Form.find(params[:id])
    render :show
  end
  
  def new
    render :new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
end
