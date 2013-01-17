class CalFacultiesController < ApplicationController
  # GET /mentor_teachers
  # GET /mentor_teachers.json
  before_filter :require_user
  def index
    @all_faculties = User.where(:owner_type => "CalFaculty")
    if params[:sort] || session[:sort] != nil
      sort = params[:sort] || session[:sort]
      case sort
      when 'first_name'
         @all_faculties = @all_faculties.order(:first_name)
      when 'last_name'
         @all_faculties = @all_faculties.order(:last_name)
      end
    end
  end
  
  def show
    store_location
    @cal_faculty = CalFaculty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cal_faculty }
    end
  end

  def new
    @cal_faculty = CalFaculty.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cal_faculty }
    end
  end

  def edit
    @cal_faculty = CalFaculty.find(params[:id])
  end

  def create
    @cal_faculty = CalFaculty.new(params[:cal_faculty])

    respond_to do |format|
      if @cal_faculty.save
        format.html { redirect_to @cal_faculty, notice: 'Cal Faculty was successfully created.' }
        format.json { render json: @cal_faculty, status: :created, location: @cal_faculty }
      else
        format.html { render action: "new" }
        format.json { render json: @cal_faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @cal_faculty = CalFaculty.find(params[:id])

    respond_to do |format|
      if @cal_faculty.update_attributes(params[:cal_faculty])
        format.html { redirect_to @cal_faculty, notice: 'Cal Faculty was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cal_faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cal_faculty = CalFaculty.find(params[:id])
    @cal_faculty.destroy

    respond_to do |format|
      format.html { redirect_to cal_faculties_url }
      format.json { head :no_content }
    end
  end
end
