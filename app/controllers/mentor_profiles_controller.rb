class MentorProfilesController < ApplicationController

  before_filter :authenticate_user!, :set_profile, only: [:show, :edit, :update, :destroy]
  before_filter :ensure_authorized, only: [:edit, :update]

  def show
    @listings = @profile.listings.includes(:listable).includes(:category).includes(:location).includes(:taggings).by_date
  end

  def update
    if @profile.update_attributes(mentor_profile_params)
      flash[:success] = "Profile updated successfully!"
      redirect_to @profile.path
    else
      render :edit
    end
  end

  def edit
    @categories = Category.all.pluck(:name)
  end

  private

  def set_profile
    @profile ||= MentorProfile.find(params[:id])
  end

  def ensure_authorized
    redirect_to root_url unless @profile == current_user.profile || current_user.admin?
  end

  def mentor_profile_params
    params.require(:mentor_profile).permit(
      :company_name,
      :company_website,
      :avatar
    )
  end
end
