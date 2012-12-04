class PagesController < ApplicationController
  
  skip_before_filter :require_user
  
  def home
  end

  def error
  end
end
