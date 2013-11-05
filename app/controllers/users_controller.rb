class UsersController < ApplicationController
  def show
    render :show
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      self.current_user = @user
      redirect user_url(@user.id)
    else
      flash.now[:errors] => @user.errors.full_messages
      render => :new
    end
  end
end
