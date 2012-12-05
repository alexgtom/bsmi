class MatchingsController < ApplicationController
  
  def show
    cur_semester = Semester.current_semester
    if not cur_semester.matchings_performed
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

end
