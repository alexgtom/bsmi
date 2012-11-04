class CalCoursesController < ApplicationController
  # GET /cal_courses
  # GET /cal_courses.json
  def index
    @cal_courses = CalCourse.all
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
    @entries = self.create_selection_for_new_course
  end

  # GET /cal_courses/new
  # GET /cal_courses/new.json
  def new
    @cal_course = CalCourse.new
    @entries = self.create_selection_for_new_course
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cal_course }
    end
  end

  # POST /cal_courses
  # POST /cal_courses.json
  def create
    @cal_course = CalCourse.new(params[:cal_course])
    if @cal_course.save  
      @cal_course.build_timeslot_associations(params[:timeslots])
      flash[:notice] = 'The course was successfully created.'
        redirect_to cal_course_path @cal_course.id
    else
      flash[:error] = 'The input data is not correct'
      render :action => :new
    end
  end

  def update
    @cal_course = CalCourse.find(params[:id])
    if @cal_course.update_attributes(params[:cal_course]) 
      if @cal_course.update_timeslot_associations(params[:timeslots])
        flash[:notice] = "CalCourse '#{@cal_course.name}' Updated!"
        redirect_to cal_course_path @cal_course.id
      end
    else
      flash[:error] = 'Something went wrong'
      render :action => :edit
    end
  end



  def create_selection_for_new_course
    entries = Array.new
    courses = Course.all
    courses.each do |course|
      times = course.timeslots
      if not times.nil?
        times.each do |time| 
          entry = time.build_entry 
          entry["course"] = course
          entries << entry
        end
      end
    end
    return entries
  end

end  

