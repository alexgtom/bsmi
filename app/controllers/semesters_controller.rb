class SemestersController < ApplicationController
  # GET /semesters
  # GET /semesters.json
  def index
    @semesters = Semester.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @semesters }
    end
  end

  # GET /semesters/1
  # GET /semesters/1.json
  def show
    @semester = Semester.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @semester }
    end
  end

  # GET /semesters/new
  # GET /semesters/new.json
  def new
    @semester = Semester.new
    @registration_deadline = Deadline.new
    @cal_courses = CalCourse.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @semester }
    end
  end

  # GET /semesters/1/edit
  def edit
    @semester = Semester.find(params[:id])
    @registration_deadline = @semester.registration_deadline
    @cal_courses = CalCourse.all
  end

  # POST /semesters
  # POST /semesters.json
  def create
    if params[:semester][:cal_courses]
      params[:semester][:cal_courses] = params[:semester][:cal_courses].map { |c| CalCourse.find(c) }
    end
    @semester = Semester.new(params[:semester])
    @registration_deadline = Deadline.new(params[:registration_deadline])
    @semester.registration_deadline = @registration_deadline
    @cal_courses = CalCourse.all

    respond_to do |format|
      if @semester.valid? and @registration_deadline.valid?
        @registration_deadline.save
        @semester.save
        format.html { redirect_to @semester, notice: 'Semester was successfully created.' }
        format.json { render json: @semester, status: :created, location: @semester }
      else
        format.html { render action: "new" }
        format.json { render json: @semester.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /semesters/1
  # PUT /semesters/1.json
  def update
    @semester = Semester.find(params[:id])
    @registration_deadline = @semester.registration_deadline
    @cal_courses = CalCourse.all

    if params[:semester][:cal_courses]
      params[:semester][:cal_courses] = params[:semester][:cal_courses].map { |c| CalCourse.find(c) }
    end

    respond_to do |format|
      if @semester.update_attributes(params[:semester])
        format.html { redirect_to @semester, notice: 'Semester was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @semester.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /semesters/1
  # DELETE /semesters/1.json
  def destroy
    @semester = Semester.find(params[:id])
    @semester.registration_deadline.destroy
    @semester.destroy

    respond_to do |format|
      format.html { redirect_to semesters_url }
      format.json { head :no_content }
    end
  end
end
