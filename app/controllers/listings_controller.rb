class ListingsController < ApplicationController

  before_filter :set_profile
  before_filter :set_listing, only: [:show, :edit, :update]
  before_filter :ensure_authorized, only: [:edit, :update]

  def show
  end

  def new
    @listing = @profile.listings.build
  end

  def create
    @listing = @profile.listings.build(listing_params)

    if @listing.save
      redirect_to @profile.path, notice: 'Successfully added job listing'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @listing.update_attributes(listing_params)
      flash[:success] = "Job listing updated successfully!"
      redirect_to @listing.path
    else
      render :edit
    end
  end

  private

  def set_profile
    @profile ||= current_user.profile
  end

  def set_listing
    @listing ||= Listing.find(params[:id])
  end

  def ensure_authorized
    redirect_to root_url unless @listing.profile == current_user.profile || current_user.admin?
  end

  def listing_params
    params.require(:listing).permit(
      :position_name, :posting_link, :contact_name, :contact_email, :description,
      :hours_per_week, :category_id, :location_id, :skill_list, :active
    )
  end
end
