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
    @course = CalCourse.find(params[:id])
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
    @a = nil
    debugger
    @b = nil
    respond_to do |format|
      if @cal_course.save
        self.setTimeslotConnections(params[:timeslots], @cal_course.id)
        format.html { redirect_to @cal_course, notice: 'The course was successfully created.' }
        format.json { render json: @cal_course, status: :created, location: @cal_courses }
      else
        format.html { render action: "new" }
        format.json { render json: @cal_course.errors, status: :unprocessable_entity }
      end
    end
  end

  def setTimeslotConnections(timeslots, id)
    if not timeslots.nil?
      timeslots.keys.each do |time_id|
        add_to = Timeslot.find_by_id(time_id)
        add_to.cal_course_id = id
        add_to.save!
      end
    end
  end

  def create_selection_for_new_course
    entries = Array.new
    courses = Course.all
    courses.each do |course|
      course.timeslots.each do |time|     
        teacher = time.mentor_teacher
        if not teacher.nil?
          school = School.find_by_name(teacher.school)
          if not school.nil?
            entry = Hash.new
            entry["course"] = course
            entry["school_level"] = school.level
            entry["school_name"] = school.name
            entry["teacher"] = teacher.user.name
            entry["time"] = time.to_string
            entry["time_id"] = time.id
            entries << entry
          end
        end
      end
    end
    return entries
  end

end  

