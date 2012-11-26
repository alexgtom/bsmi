class SettingsController < ApplicationController
  def create
    # this is really UPDATE not create
    # it updates the settings when submitted from index
    Setting['student_min_preferences'] = params['student_min_preferences']
    Setting['student_max_preferences'] = params['student_max_preferences']
    flash[:notice] = "Settings updated"
    redirect_to settings_path
  end
end
