class PagesController < ApplicationController 
  skip_before_filter :require_user
  
  layout "blank"

  def home
  end

  def error
  end
end
