class UsersController < ApplicationController
  before_filter :require_no_current_user!, :only => [:new, :create]
  before_filter :require_current_user!, :only => [:show]
  
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
        self.current_user = @user
        redirect_to forms_url
      else
        flash.now[:errors] = @user.errors.full_messages
        render :new
      end
    else
      flash.now[:errors] = ["Password does not match"]
      @user = User.new(params[:user])
      render :new
    end    
  end
end
