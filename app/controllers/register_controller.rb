class RegisterController < ApplicationController
  def index
  end

  def create
    @mentorteacher = Mentorteacher.create!(params[:mentorteacher])
    flash[:notice] = 'Your account has been successfully created!'
    redirect_to login_path
  end
end
