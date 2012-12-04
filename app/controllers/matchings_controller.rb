class MatchingsController < ApplicationController
  
  def show
    if not Semester.current_semester.matchings_performed
      redirect_to new_matching_path
    end
  end

  def new
    @placements_by_course = CalCourse.placements_by_course
  end

  def create
    unless Semester.current_semester.matchings_performed
      CalCourse.match_all
      flash[:notice] = "Successfully performed matchings"
    end
    
    redirect_to matching_path
  end

end
