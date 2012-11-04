class StudentsController < ApplicationController
  def index
    @all_student = User.where(:owner_type => "Student")
    sort = params[:sort] || session[:sort]
    case sort
    when 'name'
       @all_student = @all_student.order(:name)
    when 'course'
       @all_student = @all_student.order(:course)
    end
    if params[:search] || session[:search] != nil
      search = params[:search] || session[:search]
      search_condition = "%" + search + "%"
      @all_student = @all_student.find(:all, :conditions => ['name LIKE ?', search_condition])
    end   
      
  end
end
