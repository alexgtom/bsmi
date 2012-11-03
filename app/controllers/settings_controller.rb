class SettingsController < ApplicationController
  def index
    @settings = Setting.all
  end

  def show
    @setting = Setting.find(params[:id])
  end

  def new
    @setting = Setting.new
  end

  def edit
    @setting = Setting.find(params[:id])
  end

  def create
    @setting = Setting.new(params[:setting])

    if @setting.save
      redirect_to @setting, notice: 'Setting was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @setting = Setting.find(params[:id])

    if @setting.update_attributes(params[:setting])
      redirect_to @setting, notice: 'Setting was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @setting = Setting.find(params[:id])
    @setting.destroy

    redirect_to settings_url
  end
end
