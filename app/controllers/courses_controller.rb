class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json
  before_filter :require_admin
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])

    if @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    if @course.update_attributes(params[:course])
      redirect_to @course, notice: 'Course was successfully updated.' 
    else
      render action: "edit" 
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    redirect_to courses_url
  end
end
