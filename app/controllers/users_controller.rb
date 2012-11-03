class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_admin, :only => [:adv_edit, :adv_update]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])    
    invite_code = params[:invite_code]
    @invite = Invite.find_redeemable(invite_code)

    user_type = params[:user][:owner_type]       
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
    puts @user.owner_type
    if @user.owner_type == "Advisor"
      if @user.save
        flash[:notice] = "Advisor account created."
        redirect_to signup_url
      else
        flash[:notice] = "wrong"
        render :action => :new
      end
      return
    end

    if invite_code && @invite && @invite.email == @user.email
      if @user.save and owner.save
        @invite.redeemed!
        flash[:notice] = "Your account has been created."
        redirect_to user_path @user.id
      else
        flash[:notice] = "There was a problem creating you."
        render :action => :new
      end
    else
      flash[:notice] = "there is something wrong with this invitation."
      render :action => :new
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

  def adv_edit
    @user = User.find(params[:id])
  end

  def adv_update
    @user = User.find(params[:id])
    debugger
    if @user.update_attributes(params[:user])
      flash[:notice] = "Updated!"
      redirect_back_or_default "/students"
      return
    else
      flash[:notice] = "Something went wrong."
      render :action => :adv_edit
      return
    end    
  end
end
