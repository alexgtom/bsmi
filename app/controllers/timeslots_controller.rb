class TimeslotsController < ApplicationController
  def destroy

    @placement = Student.find().placements.find(params[:id])
    @placement.destroy

    redirect_to courses_url
    #User.find(2).owner.placements.destroy(1)
  end

    @course = Course.find(params[:id])

    if @course.update_attributes(params[:course])
      redirect_to @course, notice: 'Course was successfully updated.' 
    else
      render action: "edit" 
    end
end
