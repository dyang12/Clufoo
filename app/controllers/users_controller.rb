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
      params[:user][:account_id] = current_account.id
      
      @user = User.new(params[:user])
      
      if @user.save
        redirect_to user_url(current_user)
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

  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      redirect_to user_url(current_user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to user_url(current_user)
    end
  end
  
  def toggle_admin
    @user = User.find(params[:id])
    if @user.admin
      @user.update_attributes(:admin => nil)
    else
      @user.update_attributes(:admin => 't')
    end
    
    redirect_to user_url(current_user)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to user_url(current_user)
  end
end
