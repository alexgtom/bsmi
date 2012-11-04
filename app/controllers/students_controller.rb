class StudentsController < ApplicationController
  def index
    @all_student = User.where(:owner_type => "Student")
    if params[:sort] || session[:sort] != nil
      sort = params[:sort] || session[:sort]
      case sort
      when 'name'
         @all_student = @all_student.order(:name)
      when 'course'
         @all_student = @all_student.order(:placement)
      end
    end
    if params[:search] || session[:search] != nil
      search = params[:search] || session[:search]
      search_condition = "%" + search + "%"
      @all_student = @all_student.find(:all, :conditions => ['name LIKE ?', search_condition])
    end   
  end
  def placements
  end
end

