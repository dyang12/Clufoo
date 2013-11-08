class AccountsController < ApplicationController
  before_filter :require_no_current_user!, :only => [:new, :create]
  before_filter :require_current_user!, :only => [:show]
  
  def show
    @account = current_account
    render :show
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    if(params[:user][:password] == params[:user][:repeat])
      params[:user][:repeat] = nil
      params[:user][:admin] = 't'
      
      @account = Account.new
      params[:user][:account_id] = @account.id
      @user = User.new(params[:user])
      @account.creator_id = @user.id
      @account.save
      
      
      if @user.save
        self.current_user = @user
        redirect_to forms_url(current_account)
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
end
