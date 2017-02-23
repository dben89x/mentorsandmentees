class MenteeProfilesController < ApplicationController

  before_filter :authenticate_user!, :set_profile, only: [:show, :edit, :update, :destroy]
  before_filter :ensure_authorized, only: [:edit, :update]

  def show
  end

  def update
    if @profile.update_attributes(mentee_profile_params)
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
    @profile ||= MenteeProfile.find(params[:id])
  end

  def ensure_authorized
    redirect_to root_url unless @profile == current_user.profile || current_user.admin?
  end

  def mentee_profile_params
    params.require(:mentee_profile).permit(
      :first_name,
      :last_name,
      :linked_in,
      :avatar,
      listing_attributes: [
        :skill_list,
        :location_id,
        :hours_per_week,
        :category_id,
        :description,
        :active
      ]
    )
  end
end
