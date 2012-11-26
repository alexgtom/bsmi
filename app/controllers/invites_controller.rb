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

  def new_excel
    render :file => 'app/views/invites/new_excel.rhtml'
  end

  def uploadFile_and_invite
    uploader = FileUploader.new
    uploader.cache!(params[:upload][:datafile])
    @excel_file = RubyXL::Parser.parse(uploader.file.file)
    @worksheet = @excel_file[0].extract_data

    @invite_cnt = 0

    0.upto @worksheet.size-1 do |index|
      row = @worksheet[index]

      @invite = Invite.new({:owner_type => row[0],
                            :first_name => row[1],
                            :last_name => row[2],
                            :email => row[3]
                           })
      if @invite.save
        @invite.invite!
        mail = InvitationMailer.invite(@invite)
        mail.deliver
        @invite_cnt += 1
      else
        next
      end
    end

    flash[:notice] = "#{@invite_cnt} user successfully invited!"
    redirect_to action: :index
  end
end
