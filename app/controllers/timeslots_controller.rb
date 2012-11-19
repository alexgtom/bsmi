class TimeslotsController < ApplicationController
  def destroy
    @name = Student.find_by_id(session[:student_id]).user.first_name + Student.find_by_id(session[:student_id]).user.last_name
    @placements = Student.find_by_id(session[:student_id]).placements
    @placements.destroy(params[:id])
    session[:student_id] = nil
    redirect_to students_path, :notice => "The selected placement has been removed for #{@name}"
  end

end
