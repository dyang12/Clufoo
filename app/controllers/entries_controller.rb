class EntriesController < ApplicationController
  before_filter :require_current_user!
  
  def index
    @form = Form.find(params[:form_id])
    @entries = @form.entries
    render :index
  end
  
  def show
    @entry = Entry.find(params[:id])
    @form = Form.find(@entry.form_id)
    render :show
  end
  
  def new
    @form = Form.find(params[:form_id])
    @entry = Entry.new
    render :new
  end
  
  def create
    @form = Form.find(params[:form_id])
    
    if @form.entries.length > 0
      display_id = @form.entries[@form.entries.length-1].display_id+1
    else
      display_id = 1
    end
    
    @entry = Entry.new(:account_id => current_account.id,
                       :display_id => display_id,
                       :form_id => params[:form_id],
                       :response_data => params[:entry])

    if @entry.save
      if @form.forward_email
        msg = UserMailer.notification_email(@form.forward_email, @entry)
        msg.deliver!
      end
      
      redirect_to form_entries_url(@entry.form_id)
    else
      flash.now[:errors] = @entry.errors.full_messages
      render :new
    end
  end
  
  def edit
    @entry = Entry.find(params[:id])
    @form = @entry.form
    render :edit
  end
  
  def update
    @entry = Entry.find(params[:id])
    @form = @entry.form
    
    if @entry.update_attributes(:response_data => params[:entry])
      redirect_to form_entries_url(@entry.form_id)
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
