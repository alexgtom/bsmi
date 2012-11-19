class TimeslotsController < ApplicationController
  def destroy
    @name = Student.find_by_id(params[:student_id]).user.first_name + Student.find_by_id(params[:student_id]).user.last_name
    @placements = Student.find_by_id(params[:student_id]).placements
    @placements.destroy(params[:id])
    redirect_to "students/#{params[:student_id]}/edit_placements", :notice => "The selected placement has been removed for #{@name}"
  end


end
