class TimeslotsController < ApplicationController
  def index
    if not params[:semester_id]
      render "home"
      return
    end

    @assigned_timeslots = Timeslot.where(:semester_id => params[:semester_id]).select {|t| t.cal_course != nil}
    @unassigned_timeslots = Timeslot.where(:semester_id => params[:semester_id]).select {|t| t.cal_course == nil}
    @semester = Semester.find(params[:semester_id])

  end


  def destroy
    @name = Student.find_by_id(params[:student_id]).first_name + Student.find_by_id(params[:student_id]).last_name
    @placements = Student.find_by_id(params[:student_id]).placements
    @placements.delete(Timeslot.find_by_id(params[:timeslot_id]))
    redirect_to "students", :notice => "The selected placement has been removed for #{@name}"
  end

  def show
    @timeslot = Timeslot.find(params[:id])
    @semester = @timeslot.semester
  end

  def edit

  end
end
