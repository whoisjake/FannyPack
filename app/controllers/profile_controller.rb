class ProfileController < ApplicationController
  
  before_filter :authorize, :except => [:photo, :new, :create, :search, :autocomplete]
  
  def index
    redirect_to :action => :show
  end

  def search
  
  end
  
  def autocomplete
    if @params['search']
        @users = User.find(:all,
          :order_by => 'username',
          :conditions => [ 'LOWER(username) LIKE ?',
          '%' + @params['search'].downcase + '%' ])
        @mark_term = @params['search']
    else
      @users = User.find(:all, 
        :order_by => 'username')
    end
    render_without_layout
  end

  def show
    @heading = 'Profile'
    if @params[:id]
      @user = User.find(@params[:id])
    else
      @user = session[:user]
    end
    
    rescue
      flash[:notice] = 'User not available.'
      redirect_on_error
  end

  def new
    @heading = 'New Profile'
    @user = User.new
  end

  def create
    @heading = 'New Profile'
    @user = User.new(@params[:user])
    if @user.save
      session[:user] = @user
      flash[:notice] = 'User was successfully created.'
      redirect_to_welcome
    else
      render_action 'new'
    end
  end

  def edit
    @heading = 'Edit Profile'
    @user = session[:user]
    
    rescue
      flash[:notice] = 'User not available.'
      redirect_on_error
  end

  def update
    @heading = 'Update Profile'
    @user = User.find(@params[:id])
    
    if (@user.id == session[:user].id)
      @user = session[:user]
    end
    
    if @user.update_attributes(@params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to :action => 'show', :id => @user
    else
      render_action 'edit'
    end
  end
  
  # Displays a user's photo or a default
  def photo
    @user = User.find(@params[:id])
    
    if (@user.photo)
      send_data(@user.photo,
      :filename => @user.id,
      :type => @user.photo_type,
      :disposition => "inline")
    else
      redirect_to_path '/images/default.jpg'
    end
  end
  
  # Declines an invitation from another user.
  def decline_invitation
    @heading = 'Decline Invitation'
    user = session[:user]
    invitation = Invitation.find(@params[:id])
    
    if user.id == invitation.user.id
      invitation.destroy
      render_text ''
    end
  end
  
  # Displays a list of friends currently logged in
  def view_people
    user = session[:user]
    @people = user.get_logged_in_users
    
    render_partial 'people', :people => @people
    
    rescue
      render_text ''
  end

  # Removes the current user from the database.
  def destroy
    @heading = 'Delete Profile'
    @user = session[:user]
    @user.destroy
    flash[:notice] = 'User was successfully deleted.'
    redirect_to_login
  end
 
end
