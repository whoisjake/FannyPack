class InvitationsController < ApplicationController
  def index
    @heading = 'Invitations'
    list
    render_action 'list'
  end

  def list
    @heading = 'Invitations'
    @invitation_pages, @invitations = paginate :invitation, :per_page => 10
  end

  def show
    @heading = 'Invitation'
    @invitation = Invitation.find(@params[:id])
  end

  def new
    @heading = 'New Invitation'
    @invitation = Invitation.new
  end

  def create
    @heading = 'New Invitation'
    @invitation = Invitation.new(@params[:invitation])
    if @invitation.save
      flash['notice'] = 'Invitation was successfully created.'
      redirect_to :action => 'list'
    else
      render_action 'new'
    end
  end

  def edit
    @heading = 'Edit Invitation'
    @invitation = Invitation.find(@params[:id])
  end

  def update
    @heading = 'Update Invitation'
    @invitation = Invitation.find(@params[:id])
    if @invitation.update_attributes(@params[:invitation])
      flash['notice'] = 'Invitation was successfully updated.'
      redirect_to :action => 'show', :id => @invitation
    else
      render_action 'edit'
    end
  end

  def destroy
    @heading = 'Delete Invitation'
    Invitation.find(@params[:id]).destroy
    redirect_to :action => 'list'
  end
end
