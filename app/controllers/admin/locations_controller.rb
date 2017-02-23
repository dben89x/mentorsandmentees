class Admin::LocationsController < ApplicationController
  before_filter :authenticate_user!, :ensure_admin
  before_filter :find_location, only: [:edit, :update, :destroy]

  add_breadcrumb 'Admin Dashboard', :admin_path
  add_breadcrumb 'Locations', :admin_locations_path

  def index
    @locations = Location.all
  end

  def new
    add_breadcrumb 'New'

    @location = Location.new
  end

  def create
    @location = Location.new(location_params)

    if @location.valid?
      @location.save!
      flash[:success] = "Added location: #{@location.city_and_state}"
      redirect_to admin_locations_path
    else
      render :new
    end
  end

  def edit
    add_breadcrumb 'Edit'
  end

  def update
    if @location.update_attributes(location_params)
      flash[:success] = "Location updated successfully!"
      redirect_to admin_locations_path(@location)
    else
      render :edit
    end
  end

  private

  def find_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:city, :state, :state_abbreviation)
  end
end
