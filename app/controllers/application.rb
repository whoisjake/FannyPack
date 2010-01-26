# The filters added to this controller will be run for all controllers in the application.
# Likewise will all the methods added be available for all controllers.
class ApplicationController < ActionController::Base
  model :user
  model :message
  model :event
  model :group
   
  protected
  before_filter :update_user_activity
  
  # Sets the most recent activity time for the user.
  def update_user_activity
    user = session[:user]
    if user
      user.update_activity_timestamp()
      user.save
    end
  end
  
  # Ensures that the user has access to the requested resource.
  def authorize
    unless session[:user]
      flash[:notice] = 'Please login'
      redirect_to_login
    end
  end
  
  # Redirects when an error occurs.
  def redirect_on_error
    redirect_to :controller => 'welcome'
  end
  
  # Redirects to the login page.
  def redirect_to_login
    redirect_to :controller => 'login'
  end
  
  # Redirects to the welcome page.
  def redirect_to_welcome
    redirect_to :controller => 'welcome'
  end

end