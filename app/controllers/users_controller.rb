class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_admin, :only => [:destroy, :adv_new, :adv_create, :adv_show, :adv_edit, :adv_update]
  before_filter :only => [:user_show] do |c| c.send(:require_user_type, "CalFaculty, MentorTeacher") end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    invite_code = params[:invite_code]
    @invite = Invite.find_redeemable(invite_code)

    user_type = params[:owner_type]

    begin
     owner = User.build_owner(user_type)
    rescue ArgumentError
      flash[:notice] = "There was a problem creating you."
      render :action => :new; return
    end

    @user.owner = owner
    
    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the User has not yet been activated

    # for test purpose,
#    puts @user.owner_type
#    if @user.owner_type == "Advisor"
#      if current_user.owner_type == "Advisor" && @user.save
#        flash[:notice] = "Advisor account created."
#        redirect_to signup_url
#      else
#        flash[:notice] = "Something went wrong."
#        render :action => :new
#      end
#      return
#    end
    
    if invite_code && @invite && @invite.email == @user.email && @invite.owner_type == @user.owner_type
      if @user.save and owner.save
        @invite.redeemed!
        flash[:notice] = "Your account has been created."
        redirect_to user_path @user.id
        return
      else
        flash[:notice] = "There was a problem creating you."
        render :action => :new
        return
      end
    else
      flash[:notice] = "there is something wrong with this invitation."
      render :action => :new
      return
    end
    
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_path @user.id
    else
      render :action => :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User '#{@user.email}' deleted."
    redirect_back_or_default "/students"
  end

  def adv_new
    @user = User.new
  end

  def adv_create
    @user = User.new(params[:user])

    user_type = params[:user][:owner_type]
    begin
     owner = User.build_owner(user_type)
    rescue ArgumentError
      flash[:notice] = "There was a problem creating you."
      render :action => :adv_new; return
    end

    @user.owner = owner

    if @user.save and owner.save
      flash[:notice] = "A user account has been created."
      redirect_back_or_default "/students"
    else
      flash[:notice] = "There was a problem creating a user."
      render :action => :adv_new
    end
  end

  def adv_show
    @user = User.find(params[:id])
  end

  def user_show
    @user = User.find(params[:id])
  end

  def adv_edit
    @user = User.find(params[:id])
  end

  def adv_update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User '#{@user.email}' Updated!"
      redirect_back_or_default "/students"
      return
    else
      flash[:notice] = "Something went wrong."
      render :action => :adv_edit
      return
    end
  end
end
