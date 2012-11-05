class InvitesController < ApplicationController
  before_filter :require_admin

  def send_invitation
    @invite = Invite.find(params[:id])
    @invite.invite!
    mail = InvitationMailer.invite(@invite)
    mail.deliver
    redirect_to(invites_url, :notice => "Invite sent to #{@invite.email}")
  end

  def index
    @invites = Invite.all
  end

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(params[:invite])

    if @invite.save
      flash[:notice] = "Invite was successfully created."
      redirect_to action: :index
    else      
      flash[:notice] = "There was a problem inviting a user."
      render :action => :new
    end
  end
end
