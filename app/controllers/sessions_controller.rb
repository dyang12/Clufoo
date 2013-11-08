class SessionsController < ApplicationController
  before_filter :require_no_current_user!, :only => [:new, :create]
  before_filter :require_current_user!, :only => [:destroy]
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    user = User.find_by_credentials(params[:user][:username],
                                    params[:user][:password])

    if user.nil?
      @user = User.new(params[:user])
      flash.now[:errors] = ["Credentials were wrong"]
      render :new
    else
      self.current_user = user
      redirect_to forms_url
    end
  end

  def destroy
    logout_current_user!
    redirect_to new_session_url
  end
end
