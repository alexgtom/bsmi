class DistrictsController < ApplicationController
  def index
    @districts = District.all
  end

  def show
    @district = District.find(params[:id])
  end

  def new
    @district = District.new
  end

  def edit
    @district = District.find(params[:id])
  end

  def create
    @district = District.new(params[:district])

    if @district.save
      redirect_to @district, notice: 'District was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @district = District.find(params[:id])

    if @district.update_attributes(params[:district])
      redirect_to @district, notice: 'District was successfully updated.' 
    else
      render action: "edit" 
    end
  end

  def destroy
    @district = District.find(params[:id])
    @district.destroy

    redirect_to districts_url
  end
end
