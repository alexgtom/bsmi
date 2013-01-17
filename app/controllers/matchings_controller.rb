class MatchingsController < ApplicationController
  
  def show
    cur_semester = Semester.current_semester
    if not cur_semester
      flash[:error] = "A semester has not been created or started yet. Please wait until the semester starts or create a new semester"
      redirect_to error_path
      return
    elsif not cur_semester.matchings_performed
      redirect_to new_matching_path
    end

    @placements_by_course = Matching.by_cal_course(cur_semester)
  end

  def new

  end

  def create
    unless Semester.current_semester.matchings_performed
      CalCourse.match_all
      flash[:notice] = "Successfully performed matchings"
    end
    
    redirect_to matching_path
  end

  def destroy
    reset_id = params[:semester_id]
    semester_to_reset = reset_id.nil? ? semester : Semester.find(reset_id)
    semester_to_reset.reset_matchings

    redirect_to new_matching_path
  end

end
