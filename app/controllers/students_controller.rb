class StudentsController < ApplicationController
  def index
    @all_student = Student.all
    if params[:sort] || session[:sort] != nil
      sort = params[:sort] || session[:sort]
      case sort
      when 'first_name'
         @all_student.sort_by!{|student| student.user.first_name}
      when 'last_name'
         @all_student.sort_by!{|student| student.user.last_name}
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
      @name = User.find_by_id(params[:student_id]).first_name + User.find_by_id(params[:student_id]).last_name
      @placements = User.find_by_id(params[:student_id]).owner.placements
      @placements.delete(Timeslot.find_by_id(params[:timeslot_id]))
      redirect_to edit_placements_student_path(params[:student_id]), :notice => "The selected placement has been removed for #{@name}"
    end
    if User.find_by_id(params[:id]) == nil
       redirect_to students_path, :notice => "No such a student exists, or student has been removed"
    else
      @student = Student.find_by_id(params[:id])
      @placements = @student.placements
      @first_name = @student.user.first_name
      @last_name = @student.user.last_name
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
    @cal_courses = @student.cal_courses
  end

  def select_courses
    @student = Student.find(params[:id])
    @cal_courses = CalCourse.all

    if params[:student] and params[:student][:cal_courses]
      cal_courses = params[:student][:cal_courses].map { |id| CalCourse.find(id) }

      @student.cal_courses = cal_courses
      @student.save!

      # redirect to timeslot page of first Cal Course
      redirect_to student_select_timeslots_path(@student.id, semester, @student.cal_courses.order("name ASC").first)
    elsif params[:student] and params[:student][:check]
      # zero cal courses checked
      @student.cal_courses.destroy_all
    end
  end

  def splash
    @semester = Semester.find(params[:semester_id])
  end

  def home
  end

  def show
    @student = Student.find(params[:id])
  end

  def send_repo
    @student = Student.find(params[:id])
    if @student
      @student.send_report
    end
    redirect_to student_path @student.id
  end
end

