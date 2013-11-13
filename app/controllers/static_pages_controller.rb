class StaticPagesController < ApplicationController
  def help
    render :help
  end
  
  def root
    if current_user
      redirect_to forms_url
    else
      render :root
    end
  end
end
