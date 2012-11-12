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
      #when 'course'
      #   @all_student = @all_student.order(:placements)
      end
    end
=begin
    if params[:search] || session[:search] != nil
      search = params[:search] || session[:search]
      search_condition = "%" + search + "%"
      @all_student = @all_student.find(:all, :conditions => ['name LIKE ?', search_condition])
    end
=end   
  end

  def placements
    @placements = Student.find(params[:id]).placements
  end

  def courses
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

end

