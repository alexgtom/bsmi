#module MentorTeacher; end

class MentorTeacher::SchedulesController < ApplicationController
    #MentorTeacher has many timeslots
    
   
  def new
    #timeslots == JSON.parser(params[:timeslots])
    # @schedule = []
    if current_user
      params[:timeslots].each do |hash|
        @timeslot == Timeslot.new(hash)
        current_user.timeslots << @timeslot
      end
      current_user.save
    end
  end

  def show
    if current_user
       @timeslot = current_user.timeslots
    end
  end
  
  def create
   if current_user
    params[:timeslots].each do |hash|
      @timeslot = Timeslot.create!(hash)
      current_user.timeslots << @timeslot
    end
    flash[:notice] = "Schedule was successfully created."
    # redirect_to mentor_teacher_schedule_path
   end
  end

  def edit
   # @timeslot = Timeslot.find(params[:id])
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
