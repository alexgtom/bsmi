class MentorTeacher::SchedulesController < ApplicationController

  def current_teacher
    return current_user.owner
  end
   
  def new
    if not current_teacher.timeslots.empty?
      redirect_to edit_mentor_teacher_schedule_path 
    else
      @timeslots = []
      @read_only = false
      @submit_link = mentor_teacher_schedule_path
      render "edit_or_new"
    end    
  end

  def show
    if current_teacher.timeslots.empty?
      redirect_to new_mentor_teacher_schedule_path
    else
      @read_only = true
      @timeslots = current_teacher.timeslots.map{|t| t.to_cal_event_hash}
    end
  end

  
  def create 
#    require 'debugger'; debugger   
    all_correct = true
    params[:timeslots].each do |json_str|      
      begin 
        timeslot = Timeslot.from_cal_event_json(json_str)        
      rescue
        all_correct = false
        break
      end      
     
      current_teacher.timeslots << timeslot
      all_correct = all_correct and current_teacher.save
    end
    if all_correct
      flash[:notice] = "Schedule was successfully created."
      redirect_to mentor_teacher_schedule_path and return
    else
      flash[:notice] = "There were some problems saving your schedule"
      redirect_to new_mentor_teacher_schedule_path and return
    end
  end

  def edit
    if current_teacher.timeslots.empty? 
      redirect_to new_mentor_teacher_schedule_path
    else
      @timeslots = current_teacher.timeslots.map{|t| t.to_cal_event_hash}
      @read_only = false
      #TODO: refactor this to not need the dummy vars
      @submit_link = mentor_teacher_schedule_path 1
      render "edit_or_new"
    end
  end


  def update
    
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
