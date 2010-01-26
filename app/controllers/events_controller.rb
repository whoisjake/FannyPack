class EventsController < ApplicationController

  before_filter :authorize
  
  def index
    @heading = 'Events'
    list
    render_action 'list'
  end

  def list
    @heading = 'Events'
    @user = session[:user]
    @event_pages, @events = paginate :event, :conditions => ["user_id = ?",@user.id], :per_page => 10
  end

  def show
    @heading = 'Event'
    @event = Event.find(@params[:id])
  end

  def new
    @heading = 'New Event'
    @event = Event.new
  end

  def create
    @heading = 'New Event'
    @user = session[:user]
    @event = Event.new(@params[:event])
    @event.user_id = @user.id
    if @event.save
      @user.events.push(@event)
      flash['notice'] = 'Event was successfully created.'
      redirect_to :action => 'list'
    else
      render_action 'new'
    end
  end

  def edit
    @heading = 'Edit Event'
    @event = Event.find(@params[:id])
  end

  def update
    @heading = 'Update Event'
    @event = Event.find(@params[:id])
    if @event.update_attributes(@params[:event])
      flash['notice'] = 'Event was successfully updated.'
      redirect_to :action => 'show', :id => @event
    else
      render_action 'edit'
    end
  end

  def destroy
    @heading = 'Delete Event'
    Event.find(@params[:id]).destroy
    redirect_to :action => 'list'
  end
end
