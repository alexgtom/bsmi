class CalFaculty::MyCalCoursesController < ApplicationController
  before_filter :require_cal_faculty, :only => [:index]

  def index
    @cal_faculty = CalFaculty.find(current_user.owner_id)
    @my_cal_courses = @cal_faculty.cal_courses.where(:semester_id => params[:semester_id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @my_faculties }
    end
  end

  def home

  end
end  

