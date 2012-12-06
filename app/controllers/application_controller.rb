class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #filter_parameter_logging :password, :password_confirmation # there are underscores :-|
  helper_method :current_user_session, :current_user, :semester

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def semester
      return @semester if defined?(@semester)
      if params[:semester_id]
        @semester = Semester.find(params[:semester_id]) || Semester::current_semester
      else
        @semester = Semester::current_semester
      end
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user_type(user_type)
      unless user_type && user_type != "" && current_user && user_type.gsub(/\s+/,"").split(",").include?(current_user.owner_type)
        store_location
        flash[:notice] = "You don't have permission to access this page."
        redirect_to root_url
        return false
      end
    end

    def require_admin
      unless current_user && current_user.owner_type == "Advisor" #admin for now
        store_location
        flash[:error] = "Only admin can access this page."
        redirect_to root_path
        return false
      end
    end

    def require_student
      unless current_user && current_user.owner_type == "Student"
        store_location
        flash[:notice] = "Only student can access this page."
        redirect_to new_user_session_url
        return false
      end
    end

    def require_cal_faculty
      unless current_user && current_user.owner_type == "CalFaculty"
        store_location
        flash[:error] = "Only Cal Faculty can access this page."
        redirect_to root_path
        return false
      end
    end

    def require_mentor_teacher
      unless current_user && current_user.owner_type == "MentorTeacher"
        store_location
        flash[:notice] = "Only Mentor Teacher can access this page."
        redirect_to new_user_session_url
        return false
      end
    end
    
    def require_user
      unless current_user
        store_location
        flash[:error] = "You must be logged in to access this page"
        redirect_to root_path
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:error] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.url
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    def check(condition, &fallback)
      if not condition
        yield
      end
    end

end
