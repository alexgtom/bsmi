class CalCoursesController < ApplicationController
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
      when "grade"
        @cal_courses.sort_by! {|course| course[:course_grade] || ""}
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
  end

  # GET /cal_courses/new
  # GET /cal_courses/new.json
  def new
    @cal_course = CalCourse.new
    @entries = @cal_course.create_selection_for_new_course
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
    @cal_course = CalCourse.new(params[:cal_course])
    if not School::LEVEL.include?(params[:cal_course][:school_type]) or not Course::GRADE.include?(params[:cal_course][:course_grade])
      flash[:error] = 'You cannot select All as School Type or Course Grade'
      @entries = @cal_course.create_selection_for_new_course
      render :action => :new
      return
    end
    if @cal_course.save  
      @cal_course.build_timeslot_associations(params[:timeslots])
      flash[:notice] = 'The course was successfully created.'
        redirect_to cal_course_path @cal_course.id
    else
      flash[:error] = 'The input data is not correct'
      @entries = @cal_course.create_selection_for_new_course
      render :action => :new
    end
  end

  # PUT /cal_courses/1
  # PUT /cal_courses/1.json
  def update
    @cal_course = CalCourse.find_by_id(params[:id])
    if not School::LEVEL.include?(params[:cal_course][:school_type]) or not Course::GRADE.include?(params[:cal_course][:course_grade])
      flash[:error] = 'You cannot select All as School Type or Course Grade'
      @entries = @cal_course.create_selection_for_new_course
      render :action => :edit
      return
    end
    if @cal_course and @cal_course.update_attributes(params[:cal_course]) 
      if @cal_course.update_timeslot_associations(params[:timeslots])
        flash[:notice] = "CalCourse '#{@cal_course.name}' Updated!"
        redirect_to cal_course_path @cal_course.id
      end
    else
      flash[:error] = 'Something went wrong'
      @entries = @cal_course.create_selection_for_new_course
      render :action => :edit
    end
  end

  # DELETE /cal_courses/1
  # DELETE /cal_courses/1.json
  def destroy
    @cal_course = CalCourse.find(params[:id])
    @cal_course.destroy_timeslot_associations
    if @cal_course.destroy
      flash[:notice] = "CalCourse '#{@cal_course.name}' succesfully destroyed."
      redirect_to :action => 'index'
    else
      flash[:error] = 'Something went wrong'
      render :action => :edit
    end
  end
end  
