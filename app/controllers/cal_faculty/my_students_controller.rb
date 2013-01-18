class CalFaculty::MyStudentsController < ApplicationController
  before_filter :require_cal_faculty, :only => [:index]

  def index
    @cal_faculty = CalFaculty.find(current_user.owner_id)
    @my_students = @cal_faculty.cal_courses.where(:semester_id => params[:semester_id]).map{|course| course.students}.flatten
    if params[:sort] || session[:sort] != nil
      sort = params[:sort] || session[:sort]
      case sort
      when 'first_name'
         @my_students = @my_students.sort_by {|x| x.user.first_name }
      when 'last_name'
         @my_students = @my_students.sort_by {|x| x.user.last_name }
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cal_faculty }
    end
  end
end  

