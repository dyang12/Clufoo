class UsersController < ApplicationController
  before_filter :require_current_user!
  
  def show
    @user = current_user
    render :show
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    if(params[:user][:password] == params[:user][:repeat])
      params[:user][:repeat] = nil
      @user = User.new(params[:user])
      
      if @user.save
        redirect_to account(current_user.account_id)
      else
        flash.now[:errors] = @user.errors.full_messages
        render :new
      end
    else
      flash.now[:errors] = ["Passwords do not match"]
      @user = User.new(params[:user])
      render :new
    end    
  end
  
  def edit
    render :edit
  end
  
  def update
    
  end
  
  def destroy
    
  end
end
