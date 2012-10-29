class StudentsController < ApplicationController
  def index
    @all_student = User.where(:owner_type => "Student")
  end
end
