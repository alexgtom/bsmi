class CalCoursesController < ApplicationController
#before filter -- advisor or cal_faculty only access for everything
  # GET /cal_courses
  # GET /cal_courses.json
  def index
    if not params[:semester_id]
      render "home"
      return
    end
    @cal_courses = CalCourse.where(:semester_id => params[:semester_id])
    @semester = Semester.find(params[:semester_id])
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
    @times = @cal_course.timeslots
    @semester = @cal_course.semester
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cal_courses }
    end
  end

  # GET /cal_courses/1/edit
  def edit
    @cal_course = CalCourse.find(params[:id])
    @semester = @cal_course.semester
    @entries = @cal_course.create_selection_for_new_course
  end

  # GET /cal_courses/new
  # GET /cal_courses/new.json
  def new
    @cal_course = CalCourse.new
    @entries = @cal_course.create_selection_for_new_course
    @semester = Semester.find(params[:semester_id])
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
    @semester = params[:semester_id]
    School::LEVEL.include?(params[:cal_course][:school_type])

    @cal_course.semester_id = params[:cal_course][:semester_id]
    @cal_course.build_associations(params[:timeslots], params["cal_faculty"])
    @cal_course.save!
    flash[:notice] = 'The course was successfully created.'
    redirect_to cal_course_path(@cal_course, {:semester_id => params[:semester_id]})
  end

  # PUT /cal_courses/1
  # PUT /cal_courses/1.json
  def update
    @cal_course = CalCourse.find_by_id(params[:id])
    School::LEVEL.include?(params[:cal_course][:school_type])
    @semester = @cal_course.semester       
    
    @cal_course.update_attributes(params[:cal_course])

    @cal_course.cal_faculties.delete_all
    if params[:cal_faculty]
      params[:cal_faculty].each_key{|id| @cal_course.cal_faculties << CalFaculty.find(id)}
    end

    @cal_course.timeslots.delete_all
    if params[:timeslots]
      params[:timeslots].each_key{|id| @cal_course.timeslots << Timeslot.find(id)}
    end

    @cal_course.save!
    flash[:notice] = 'The course was successfully updated.'
    redirect_to cal_course_path(@cal_course, {:semester_id => params[:semester_id]})
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
