class Admin::FeaturedStartupsController < ApplicationController
  before_filter :authenticate_user!, :ensure_admin
  before_filter :find_featured_startup, only: [:destroy]

  add_breadcrumb 'Admin Dashboard', :admin_path

  def new
    add_breadcrumb 'New Featured Startups', :new_admin_featured_startup_path
    @featured_startup = FeaturedStartup.new
  end

  def create
    @featured_startup = FeaturedStartup.new(featured_startup_params)

    if @featured_startup.save
      flash[:success] = "Added featured startup: #{@featured_startup.name}"
      redirect_to admin_path
    else
      render :new
    end
  end

  def destroy
    if @featured_startup.destroy
      flash[:success] = "Removed featured startup: #{@featured_startup.name}"
    else
      flash[:error] = "Something went wrong. Please contact Allan."
    end

    redirect_to admin_path
  end

  private

  def find_featured_startup
    @featured_startup = FeaturedStartup.find(params[:id])
  end

  def featured_startup_params
    params.require(:featured_startup).permit(:startup_profile_id)
  end
end
