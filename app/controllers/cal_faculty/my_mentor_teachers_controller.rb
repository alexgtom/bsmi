class CalFaculty::MyMentorTeachersController < ApplicationController
  before_filter :require_cal_faculty, :only => [:index]

  def index
    @cal_faculty = CalFaculty.find(current_user.owner_id)
    @my_students = @cal_faculty.students
    @my_faculties = @cal_faculty.mentor_teachers
    @my_faculties = @my_faculties.uniq {|x| x.user.id }
    if params[:sort] || session[:sort] != nil
      sort = params[:sort] || session[:sort]
      case sort
      when 'first_name'
         @my_faculties = @my_faculties.sort_by {|x| x.user.first_name }
      when 'last_name'
         @my_faculties = @my_faculties.sort_by {|x| x.user.last_name }
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @my_faculties }
    end
  end
end  

