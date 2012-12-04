class MentorTeacher::MyStudentsController < ApplicationController
  before_filter :require_mentor_teacher, :only => [:index]

  def index
    @semester = Semester.find(params[:semester_id])
    @mentor_teacher = MentorTeacher.find(current_user.owner_id)
    @my_students = @mentor_teacher.students
    @my_students = @my_students.select { |x| x.semester.id == @semester.id }
    @my_students = @my_students.uniq {|x| x.user.id }
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

