class MentorTeacher::SchedulesController < ApplicationController

  def current_teacher
    return current_user.owner
  end
   
  def new
    if not current_teacher.timeslots.empty?
      redirect_to edit_mentor_teacher_schedule_path 
    else
      @course_names = Course.select(:name).map{|row| row.name}
      @timeslots = []
      @read_only = false
      @method = :post
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
      redirect_to mentor_teacher_schedule_path
    else
      flash[:notice] = "There were some problems saving your schedule"
      redirect_to new_mentor_teacher_schedule_path 
    end
  end

  def edit
    if current_teacher.timeslots.empty? 
      redirect_to new_mentor_teacher_schedule_path
    else
      semester_id = params[:semester_id] || semester.id
      @timeslots = current_teacher.timeslots_for_semester(semester_id).
        map{|t| t.to_cal_event_hash}

      @course_names = Course.select(:name).map{|row| row.name}
      @read_only = false
      #TODO: refactor this to not need the dummy vars
      @submit_link = mentor_teacher_schedule_path
      @method = :put
      render "edit_or_new"
    end
  end


  def update    
    errors = 0
    if params[:timeslots]
      params[:timeslots].each do |json_str|

        event = JSON.parse(json_str)
        if not current_teacher.timeslots.find_by_id event["db_id"]
          #Prevent anyone from updating a Timeslot that doesn't belong to them
          event["db_id"] = nil        
        end
        updated_slot = Timeslot.from_cal_event_hash(event)      

        if event["destroy"]
          updated_slot.delete
          next
        end

        errors += 1 unless updated_slot.save
        current_teacher.timeslots << updated_slot
      end
   end
    if errors > 0
      flash[:notice] = "Couldn't save all classes in schedule"
      redirect_to edit_mentor_teacher_schedule_path
    else
      flash[:notice] = "Successfully updated schedule"
      redirect_to mentor_teacher_schedule_path
    end
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
