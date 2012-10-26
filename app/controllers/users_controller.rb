class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end

  def create        
    @user = User.new(params[:user])    
        
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
    if @user.save and owner.save
      flash[:notice] = "Your account has been created."
      redirect_to signup_url
    else
      flash[:notice] = "There was a problem creating you."
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
end
