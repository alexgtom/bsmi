class PagesController < ApplicationController 
  skip_before_filter :require_user
  
  layout "blank"

  def home
    if current_user
      if current_user.owner_type == "Student"
        redirect_to home_student_path(current_user.owner_id)
      else 
        redirect_back_or_default account_url(current_user)
      end
    end
  end

  def error
  end
end
