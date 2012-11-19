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
    @placements = Student.find(params[:id]).placements
    @first_name = User.find(params[:id]).first_name
    @last_name = User.find(params[:id]).last_name
    @student = Student.find(params[:id])
  end
  
  def update
    @student = Student.find(params[:id])
    @new_placement = Timeslot.find_by_id(params[:student][:placement])
    if @student.update_attributes(params[:placements])
      redirect_to @student, notice: 'Placements was successfully updated.' 
    else
      render action: "edit" 
    end
    #User.find(2).owner.placements<<(Timeslot.find(1))
    #User.find(2).owner.placements.destroy(1)
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

