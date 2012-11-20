class StudentsController < ApplicationController
  def index
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
    @placements = Student.find(params[:id]).placements
  end

  def edit_placements
    if params[:new_timeslot] != nil
       if Student.find_by_id(params[:id]).placements.find_by_id(params[:new_timeslot]) == nil
          Student.find_by_id(params[:id]).placements << Timeslot.find_by_id(params[:new_timeslot])
       else
       	  redirect_to edit_placements_student_path(params[:id]), :notice => "The student already has the placement you were trying to add."
       end
    end
    if params[:student_id] != nil && params[:timeslot_id] != nil
      @name = Student.find_by_id(params[:student_id]).user.first_name + Student.find_by_id(params[:student_id]).user.last_name
      @placements = Student.find_by_id(params[:student_id]).placements
      @placements.delete(Timeslot.find_by_id(params[:timeslot_id]))
      redirect_to edit_placements_student_path(params[:student_id]), :notice => "The selected placement has been removed for #{@name}"
    end
    if Student.find_by_id(params[:id]) == nil
       redirect_to students_path, :notice => "No such a student exists, or student has been removed"
    else
      @placements = Student.find(params[:id]).placements
      @first_name = Student.find(params[:id]).user.first_name
      @last_name = Student.find(params[:id]).user.last_name
      @student = Student.find(params[:id])
    end
  end
  

  def update
    @student = Student.find(params[:id])
    @new_placement = Timeslot.find_by_id(params[:student][:placement])
    if @student.update_attributes(params[:placements])
      redirect_to @student, notice: 'Placements was successfully updated.' 
    else
      render action: "edit" 
    end
  end
  def courses
    @student = Student.find(params[:id])
    @cal_courses = Student.find(params[:id]).cal_courses
  end

  def select_courses
    @student = Student.find(params[:id])
    @cal_courses = CalCourse.all

    if params[:student] and params[:student][:cal_courses]
      cal_courses = params[:student][:cal_courses].map { |id| CalCourse.find(id) }
      @student.update_attribute(:cal_courses, cal_courses)
      redirect_to action: "courses"
    end
  end

  def show
    @student = Student.find(params[:id])
  end
end

