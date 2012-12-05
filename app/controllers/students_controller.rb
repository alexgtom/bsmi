class StudentsController < ApplicationController
#  before_filter :require_student, :only => [:placements]
#  before_filter :require_cal_faculty, :only => [:placements]
  
  def index
    @all_student = Student.all
    if params[:sort] || session[:sort] != nil
      sort = params[:sort] || session[:sort]
      case sort
      when 'first_name'
         @all_student.sort_by!{|student| student.user.first_name}
      when 'last_name'
         @all_student.sort_by!{|student| student.user.last_name}
      end
    end
  end

  def placements
    @semester = Semester.find(params[:semester_id])
    if current_user.owner_type == "Advisor"
      @placements = Student.find(params[:id]).placements
    else
      @placements = Student.find(current_user.owner.id).placements
    end
  end

  def edit_placements
    if params[:new_timeslot] != nil
       if Student.find_by_id(params[:id]).placements.find_by_id(params[:new_timeslot]) == nil
          Student.find_by_id(params[:id]).placements << Timeslot.find_by_id(params[:new_timeslot])
       else
       	  redirect_to edit_placements_student_path(params[:id]), :notice => "The student already has the placement you were trying to add."
       end
    end
    if params[:student_id] != nil && params[:timeslot_id] != nil
      @name = Student.find_by_id(params[:student_id]).user.first_name + Student.find_by_id(params[:student_id]).user.last_name
      @placements = Student.find_by_id(params[:student_id]).placements
      @placements.delete(Timeslot.find_by_id(params[:timeslot_id]))
      redirect_to edit_placements_student_path(params[:student_id]), :notice => "The selected placement has been removed for #{@name}"
    end
    if Student.find_by_id(params[:id]) == nil
       redirect_to students_path, :notice => "No such a student exists, or student has been removed"
    else
      @student = Student.find_by_id(params[:id])
      @placements = @student.placements
      @first_name = @student.user.first_name
      @last_name = @student.user.last_name
    end
  end
  

  def update
    @student = Student.find(params[:id])
    @new_placement = Timeslot.find_by_id(params[:student][:placement])
    if @student.update_attributes(params[:placements])
      redirect_to @student, notice: 'Placements was successfully updated.' 
    else
      render action: "edit" 
    end
  end

  def courses
    @student = Student.find(params[:id])
    @cal_courses = Student.find(params[:id]).cal_courses
  end

  def select_courses
    @semester = Semester.find(params[:semester_id])
    @student = Student.find(params[:id])
    @cal_courses = CalCourse.all

    if params[:student] and params[:student][:cal_courses]
      cal_courses = params[:student][:cal_courses].map { |id| CalCourse.find(id) }

      @student.cal_courses = cal_courses
      @student.save!

      # redirect to timeslot page of first Cal Course
      redirect_to student_select_timeslots_path(@student.id, semester, @student.cal_courses.order("name ASC").first)
    elsif params[:student] and params[:student][:check]
      # zero cal courses checked
      @student.cal_courses.destroy_all
    end
  end

  def splash
    @semester = Semester.find(params[:semester_id])
  end

  def home
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    flash[:notice] = "User '#{@student.user.email}' deleted."
    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end

  def show
    store_location
    @student = Student.find(params[:id])
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    flash[:notice] = "User '#{@student.user.email}' deleted."
    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end

  def download_pdf
    teacher = MentorTeacher.find(params[:id])
    send_data generate_pdf(teacher),
              filename: "#{teacher.user.name}.pdf",
              type: "application/pdf"
  end
 
  private
  def generate_pdf(student)
    Prawn::Document.new do
      text "UC Berkeley", :size => 20, :align => :right, :style => :bold
      stroke {y=@y-30; line [1,y], [bounds.width,y]}
      text "CalTeach Student Report", :size => 24, :align => :center, :style => :bold
      text "Date: #{Time.now.to_s}"
      text "Name: #{student.user.name}"
      text "Address: #{student.user.street_address}" 
      text "Email: #{student.user.email}"
      student.placements.each do |timeslot| 
        teacher = timeslot.mentor_teacher ? timeslot.mentor_teacher.user.name : " "
        entry = timeslot.build_entry(student.id)
        school = entry["school_name"]
        course = entry["course"] ? entry["course"].name : " "
        grade = entry["course"] ? entry["course"].grade : " "
        time = entry["time"]
        data = [ ['Semester',"#{timeslot.semester.description}"],
                 ['Cal Course', "#{timeslot.cal_course.name}"],
                 ['School', school],
                 ['Course', course],
                 ['Grade', grade],
                 ['Time', time],
                 ['Teacher', teacher]
        ]
        move_down(30)
        table data, :header => false, :column_widths => {0 => 80, 1 => 400}
      end
    end.render
  end
end

