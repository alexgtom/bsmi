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
    @semester = Semester.find(params[:semester_id])
    @placements = User.find(params[:id]).owner.placements
  end

  def edit_placements
    @semester = Semester.find(params[:semester_id])
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
    @student = User.find(params[:id]).owner
    @new_placement = Timeslot.find_by_id(params[:student][:placement])
    if @student.update_attributes(params[:placements])
      redirect_to @student, notice: 'Placements was successfully updated.' 
    else
      render action: "edit" 
    end
  end

  def courses
    @semester = Semester.find(params[:semester_id])
    @student = User.find(params[:id]).owner
    @cal_courses = @student.cal_courses
  end

  def select_courses
    @semester = Semester.find(params[:semester_id])
    @student = User.find(params[:id]).owner
    @cal_courses = CalCourse.all

    if params[:student] and params[:student][:cal_courses]
      cal_courses = params[:student][:cal_courses].map { |id| CalCourse.find(id) }

      @student.cal_courses = cal_courses
      @student.save!

      # redirect to timeslot page of first Cal Course
      redirect_to student_select_timeslots_path(@student.id, @semester.id, @student.cal_courses.order("name ASC").first)
    elsif params[:student] and params[:student][:check]
      # zero cal courses checked
      @student.cal_courses.destroy_all
    end
  end

  def splash
    @semester = Semester.current_semester
  end

  def show
    @student = User.find(params[:id]).owner
  end
end

