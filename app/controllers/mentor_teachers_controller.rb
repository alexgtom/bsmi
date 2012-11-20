class MentorTeachersController < ApplicationController
  # GET /mentor_teachers
  # GET /mentor_teachers.json
  def index
    @all_teacher = User.where(:owner_type => "MentorTeacher")
    if params[:sort] || session[:sort] != nil
      sort = params[:sort] || session[:sort]
      case sort
      when 'first_name'
         @all_teacher = @all_teacher.order(:first_name)
      when 'last_name'
         @all_teacher = @all_teacher.order(:last_name)
      #when 'course'
       #  @all_teacher = @all_teacher.order(:placement)
      end
    end
=begin
    if params[:search] || session[:search] != nil
      search = params[:search] || session[:search]
      search_condition = "%" + search + "%"
      @all_teacher = @all_teacher.find(:all, :conditions => ['name LIKE ?', search_condition])
    end
=end   
 

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mentor_teachers }
    end
  end
  
  # GET /mentor_teachers/1
  # GET /mentor_teachers/1.json
  def show
    @mentor_teacher = MentorTeacher.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mentor_teacher }
    end
  end

  # GET /mentor_teachers/new
  # GET /mentor_teachers/new.json
  def new
    @mentor_teacher = MentorTeacher.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mentor_teacher }
    end
  end

  # GET /mentor_teachers/1/edit
  def edit
    @mentor_teacher = MentorTeacher.find(params[:id])
  end

  # POST /mentor_teachers
  # POST /mentor_teachers.json
  def create
    @mentor_teacher = MentorTeacher.new(params[:mentor_teacher])

    respond_to do |format|
      if @mentor_teacher.save
        format.html { redirect_to @mentor_teacher, notice: 'Mentor teacher was successfully created.' }
        format.json { render json: @mentor_teacher, status: :created, location: @mentor_teacher }
      else
        format.html { render action: "new" }
        format.json { render json: @mentor_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mentor_teachers/1
  # PUT /mentor_teachers/1.json
  def update
    @mentor_teacher = MentorTeacher.find(params[:id])

    respond_to do |format|
      if @mentor_teacher.update_attributes(params[:mentor_teacher])
        format.html { redirect_to @mentor_teacher, notice: 'Mentor teacher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mentor_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mentor_teachers/1
  # DELETE /mentor_teachers/1.json
  def destroy
    @mentor_teacher = MentorTeacher.find(params[:id])
    @mentor_teacher.destroy

    respond_to do |format|
      format.html { redirect_to mentor_teachers_url }
      format.json { head :no_content }
    end
  end
end
