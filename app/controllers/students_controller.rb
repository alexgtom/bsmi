class StudentsController < ApplicationController
  def placements
    @placements = Student.find(params[:id]).placements
  end
end
