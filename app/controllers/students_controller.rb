class StudentsController < ApplicationController
  def index
    store_location
    @all_student = User.where(:owner_type => "Student")
    if params[:sort] || session[:sort] != nil
      sort = params[:sort] || session[:sort]
      case sort
      when 'first_name'
         @all_student = @all_student.order(:first_name)
      when 'last_name'
         @all_student = @all_student.order(:last_name)
      end
    end
  end

  def placements
    #@placements = User.find(params[:id]).owner.placements
    @placements = Student.find(params[:id]).placements
  end

  def edit_placements
    if params[:new_timeslot] != nil
       if User.find_by_id(params[:id]).owner.placements.find_by_id(params[:new_timeslot]) == nil
          User.find_by_id(params[:id]).owner.placements << Timeslot.find_by_id(params[:new_timeslot])
       else
       	  redirect_to edit_placements_student_path(params[:id]), :notice => "The student already has the placement you were trying to add."
       end
    end
    if params[:student_id] != nil && params[:timeslot_id] != nil
      @name = User.find_by_id(params[:student_id]).first_name + User.find_by_id(params[:student_id]).last_name
      @placements = User.find_by_id(params[:student_id]).owner.placements
      @placements.delete(Timeslot.find_by_id(params[:timeslot_id]))
      redirect_to edit_placements_student_path(params[:student_id]), :notice => "The selected placement has been removed for #{@name}"
    end
    if User.find_by_id(params[:id]) == nil
       redirect_to students_path, :notice => "No such a student exists, or student has been removed"
    else
      @student = User.find_by_id(params[:id]).owner
      @placements = @student.placements
      @first_name = @student.user.first_name
      @last_name = @student.user.last_name
    end
  end
  

  def update
    #@student = User.find(params[:id]).owner
    @student = Student.find(params[:id])
    @new_placement = Timeslot.find_by_id(params[:student][:placement])
    if @student.update_attributes(params[:placements])
      redirect_to @student, notice: 'Placements was successfully updated.' 
    else
      render action: "edit" 
    end
  end
  def courses
    #@student = User.find(params[:id]).owner
    #@cal_courses = User.find(params[:id]).owner.cal_courses
    @student = Student.find(params[:id])
    @cal_courses = Student.find(params[:id]).cal_courses
  end

  def select_courses
    #@student = User.find(params[:id]).owner
    @student = Student.find(params[:id])
    @cal_courses = CalCourse.all

    if params[:student] and params[:student][:cal_courses]
      cal_courses = params[:student][:cal_courses].map { |id| CalCourse.find(id) }
      @student.update_attribute(:cal_courses, cal_courses)
      redirect_to action: "courses"
    end
  end

  def show
    store_location
    #@student = User.find(params[:id]).owner
    @student = Student.find(params[:id])
  end
end

