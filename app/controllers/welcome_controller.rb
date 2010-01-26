class WelcomeController < ApplicationController
  
  before_filter :authorize, :except => [:index]
  
  def index
    if session[:user]
      flash.keep
      redirect_to :action => :portal
    end
  end
  
  def portal
    @heading = 'Portal'
    if !session[:user]
      Flash[:notice] = 'Please log in.'
      redirect_to_welcome
    end
    
    @user = session[:user]
    
  end
  
end
