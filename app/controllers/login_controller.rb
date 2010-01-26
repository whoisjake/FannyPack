class LoginController < ApplicationController

  def index
    session[:user] = nil
    @user = User.new
  end
  
  def login
    @heading = 'Login'
    if request.get?
      session[:user] = nil
      redirect_to_login
    else
      @user = User.get_user_by_login(@params[:user][:username], @params[:user][:password])
      if(@user)
        flash[:notice] = "Welcome, #{@user.first_name.capitalize}"
        session[:user] = @user
        redirect_to_welcome
      else
        flash[:notice] = 'Invalid login/password'
        redirect_to_login
      end
    end
  end

  def logout
    @heading = 'Logout'
    session[:user] = nil
    flash[:notice] = 'Thank you for visiting Fanny Pack.'
    redirect_to_welcome
  end
end
