#module MentorTeacher; end

class MentorTeacher::SchedulesController < ApplicationController

  def current_teacher
    return current_user.owner
  end
   
  def new
    #Just render the view for now; doesn't need any data
  end

  def show
    if current_teacher.timeslots.empty?
      redirect_to mentor_teacher_schedule_new_path
    else
      @timeslots = current_teacher.timeslots
    end
  end

  
  def create    
    params[:timeslots].each do |json_str|      
      @timeslot = Timeslot.from_cal_event_json(json_str)
      @timeslot.save
      current_teacher.timeslots << @timeslot
    end
    flash[:notice] = "Schedule was successfully created."
    redirect_to mentor_teacher_schedule_path
    #   end
  end

  def edit
    
  end

  def update
=begin
    @timeslot = Timeslot.find(params[:id])
    params[:timeslots].each do |hash|
      @timeslot = Timeslot.update_attributes!(hash)
    end
    flash[:notice] = "Schedule information was successfully updated."
   # redirect_to mentor_teacher_schedule_path(@timeslot)
=end
  end

  def destroy
=begin
    @timeslot = Timeslot.find(params[:id])
    @timeslot.destroy
    flash[:notice] = "Schedule deleted."
   # redirect_to mentor_teacher_schedule_path
=end
  end
end
