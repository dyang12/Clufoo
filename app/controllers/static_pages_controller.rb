class StaticPagesController < ApplicationController
  before_filter :require_no_current_user!, :only => [:help]
  
  def help
    render :help
  end
  
  def root
    if current_user
      redirect_to forms_url
    else
      redirect_to new_session_url
    end
  end
end
