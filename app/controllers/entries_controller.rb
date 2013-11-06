class EntriesController < ApplicationController
  def index
    @form = current_user.forms.find(params[:form_id])
    @entries = @form.entries
    render :index
  end
  
  def show
    @entry = Entry.find(params[:id])
    @form = current_user.forms.find(@entry.form_id)
    render :show
  end
  
  def new
    @form = current_user.forms.find(params[:form_id])
    @entry = Entry.new
    render :new
  end
  
  def create
    @entry = Entry.new(:form_id => params[:form_id], :response_data => params[:entry])
    
    if @entry.save
      redirect_to form_entries_url(@entry.form_id)
    else
      flash.now[:errors] = @entry.errors.full_messages
      render :new
    end
  end
  
  def edit
    @form = current_user.forms.find(params[:form_id])
    @entry = Entry.find(params[:id])
    #DOES NOT WORKKK
    render :edit
  end
  
  def update
    @entry = Entry.find(params[:id])
    
    if @entry.update_attributes(params[:entry])
      render :show
    else
      flash.now[:errors] = @entry.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to form_entries_url(@entry.form_id)
  end
end
