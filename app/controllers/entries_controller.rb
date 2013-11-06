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
    @entry = Entry.new(:form_id => params[:entry][:form_id])
    fail
    #whitelist keys??
    redirect_to form_entries(@entry.form_id)
  end
  
  def edit
    @form = current_user.forms.find(params[:form_id])
    @entry = Entry.find(params[:id])
    render :edit
  end
  
  def update
  end
  
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to form_entries_url(@entry.form_id)
  end
end
