class MessagesController < ApplicationController

  before_filter :authorize
  
  def index
    @heading = 'Messages'
    list
    render_action 'list'
  end

  def list
    @heading = 'Messages'
    @user = session[:user]
    @message_pages, @messages = paginate :message,:conditions => ["user_id = ?",@user.id], :per_page => 10
  end

  def show
    @heading = 'Message'
    @message = Message.find(@params[:id])
  end

  def new
    @heading = 'New Message'
    @message = Message.new
  end

  def create
    @heading = 'New Message'
    @user = session[:user]
    @message = Message.new(@params[:message])
    @message.posted = Time.now
    @message.user_id = @user.id
    
    if @message.save
      @user.messages.push(@message)
      flash[:notice] = 'The message was sent.'
      redirect_to_welcome
    else
      render_action 'new'
    end
  end

  def edit
    @heading = 'Edit Message'
    @message = Message.find(@params[:id])
    
    if @message.user != session[:user]
      flash[:notice] = 'Message not available.'
      redirect_on_error
    end
  end

  def update
    @heading = 'Update Message'
    @message = Message.find(@params[:id])
    
    if @message.user == session[:user]
      if @message.update_attributes(@params[:message])
        flash[:notice] = 'The message was successfully updated.'
        redirect_to_welcome
      else
        render_action 'edit'
      end
    end
    
    rescue
      flash[:notice] = 'Message not found.'
      redirect_on_error
  end

  def destroy
    @heading = 'Delete Message'
    @message = Message.find(@params[:id])
    @message.destroy
    redirect_to :action => 'list'
  end
end
