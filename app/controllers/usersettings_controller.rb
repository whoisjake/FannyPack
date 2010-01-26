class UsersettingsController < ApplicationController
  def index
    list
    render_action 'list'
  end

  def list
    @heading = 'User Settings'
    @usersettings_pages, @usersettings = paginate :usersettings, :per_page => 10
  end

  def show
    @heading = 'User Setting'
    @usersettings = Usersettings.find(@params[:id])
  end

  def new
    @heading = 'New User Setting'
    @usersettings = Usersettings.new
  end

  def create
    @heading = 'New User Setting'
    @usersettings = Usersettings.new(@params[:usersettings])
    if @usersettings.save
      flash['notice'] = 'Usersettings was successfully created.'
      redirect_to :action => 'list'
    else
      render_action 'new'
    end
  end

  def edit
    @heading = 'Edit User Setting'
    @usersettings = Usersettings.find(@params[:id])
  end

  def update
    @heading = 'Update User Setting'
    @usersettings = Usersettings.find(@params[:id])
    if @usersettings.update_attributes(@params[:usersettings])
      flash['notice'] = 'Usersettings was successfully updated.'
      redirect_to :action => 'show', :id => @usersettings
    else
      render_action 'edit'
    end
  end

  def destroy
    @heading = 'Delete User Setting'
    Usersettings.find(@params[:id]).destroy
    redirect_to :action => 'list'
  end
end
