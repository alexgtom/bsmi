#module MentorTeacher; end

class MentorTeacher::SchedulesController < ApplicationController
    #MentorTeacher has many timeslots
    
=begin   
  def new
    #timeslots == JSON.parser(params[:timeslots])
    params[:timeslots].each do |hash|
      @timeslot = Timeslot.new(hash)
      cur_teacher.timeslots << @timeslot
    end
  end
=end

  def show
    id = params[] # retrieve movie ID from URI route
    @timeslot = Timeslot.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  def create

    params[:timeslots].each do |hash|
      @timeslot = Timeslot.create!(hash)
      cur_teacher.timeslots << @timeslot
    end
    flash[:notice] = "Schedule was successfully created."
    # redirect_to mentor_teacher_schedule_path
  end

  def edit
    @timeslot = Timeslot.find(params[:id])
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
    @timeslot = Timeslot.find(params[:id])
    @timeslot.destroy
    flash[:notice] = "Schedule deleted."
   # redirect_to mentor_teacher_schedule_path
  end

end
