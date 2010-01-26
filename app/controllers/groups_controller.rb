class GroupsController < ApplicationController

  before_filter :authorize
  
  
  def index
    @heading = 'Groups'
    list
    render_action 'list'
  end

  def list
    @heading = 'Groups'
    @group_pages, @groups = paginate :group, :per_page => 10
  end

  def show
    @heading = 'Group'
    @group = Group.find(@params[:id])
  end

  def new
    @heading = 'New Group'
    @group = Group.new
  end

  def create
    @heading = 'New Group'
    @group = Group.new(@params[:group])
    @user = session[:user]
    @group.user_id =  @user.id
    if @group.save
      flash['notice'] = 'Group was successfully created.'
      redirect_to :action => 'list'
    else
      render_action 'new'
    end
  end

  def edit
    @heading = 'Edit Group'
    @group = Group.find(@params[:id])
  end

  def update
    @heading = 'Update Group'
    @group = Group.find(@params[:id])
    if @group.update_attributes(@params[:group])
      flash['notice'] = 'Group was successfully updated.'
      redirect_to :action => 'show', :id => @group
    else
      render_action 'edit'
    end
  end

  def destroy
    @heading = 'Delete Group'
    Group.find(@params[:id]).destroy
    redirect_to :action => 'list'
  end
end
