class CalCoursesController < ApplicationController
#before filter -- advisor or cal_faculty only access for everything
  # GET /cal_courses
  # GET /cal_courses.json
  def index
    @cal_courses = CalCourse.all
    if params[:sort] || session[:sort] != nil
      sort = params[:sort] || session[:sort]
      case sort
      when "name"
        @cal_courses.sort_by! {|course| course[:name]}
      when "school"
        @cal_courses.sort_by! {|course| course[:school_type] || ""}
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cal_courses }
    end
  end

  # GET /cal_courses/1
  # GET /cal_courses/1.json
  def show
    @cal_course = CalCourse.find(params[:id])
    @times = Timeslot.where("cal_course_id = ?", params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cal_courses }
    end
  end

  # GET /cal_courses/1/edit
  def edit
    @cal_course = CalCourse.find(params[:id])
    @entries = @cal_course.create_selection_for_new_course
    @semesters = Semester.all.collect {|s| ["#{s.name} #{s.year}", s.id]}
  end

  # GET /cal_courses/new
  # GET /cal_courses/new.json
  def new
    @cal_course = CalCourse.new
    @entries = @cal_course.create_selection_for_new_course
    @semesters = Semester.all.collect {|s| ["#{s.name} #{s.year}", s.id]}
    if @entries.nil?
      @entries = Array.new
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cal_course }
    end
  end

  # POST /cal_courses
  # POST /cal_courses.json
  def create
    success = true
    handle_error = Proc.new do
      flash[:error] = 'Something went Wrong. Did you select a Semester and a School Type?'
      puts "error"
      @entries = CalCourse.new.create_selection_for_new_course
      @semesters = Semester.all.collect {|s| ["#{s.name} #{s.year}", s.id]}
      redirect_to new_cal_course_path and return
    end

    @cal_course = CalCourse.new(params[:cal_course])
    unless School::LEVEL.include?(params[:cal_course][:school_type]) and (not params[:cal_course][:semester_id].blank?)
      handle_error.call
    end
    handle_error.call unless @cal_course.save  

    @cal_course.build_associations(params[:timeslots], params["cal_faculty"])
    flash[:notice] = 'The course was successfully created.'
    redirect_to cal_course_path @cal_course.id                 
  end

  # PUT /cal_courses/1
  # PUT /cal_courses/1.json
  def update
    @cal_course = CalCourse.find_by_id(params[:id])
    if School::LEVEL.include?(params[:cal_course][:school_type]) and params[:cal_course][:semester_id] != ""
      @cal_course = CalCourse.find_by_id(params[:id])
      if @cal_course and @cal_course.update_attributes(params[:cal_course]) 
        @cal_course.build_associations(params[:timeslots], params[:cal_faculty])
        flash[:notice] = 'The course was successfully created.'
        redirect_to cal_course_path @cal_course.id
      end
    else
      flash[:error] = 'Something went Wrong. Did you select a Semester and a School Type?'
      @entries = @cal_course.create_selection_for_new_course
      @semesters = Semester.all.collect {|s| ["#{s.name} #{s.year}", s.id]}
      redirect_to edit_cal_course_path @cal_course.id
    end
  end


  # DELETE /cal_courses/1
  # DELETE /cal_courses/1.json
  def destroy
    @cal_course = CalCourse.find(params[:id])
    @cal_course.destroy_associations
    if @cal_course.destroy
      flash[:notice] = "CalCourse '#{@cal_course.name}' succesfully destroyed."
      redirect_to :action => 'index'
    else
      flash[:error] = 'Something went wrong'
      render :action => :edit
    end
  end
end  
