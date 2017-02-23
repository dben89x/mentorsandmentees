class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :set_role, :set_categories, only: [:new]

  private

  def set_role
    @role = params[:role]
  end

  def set_categories
    @categories = Category.all.pluck(:name)
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) { |u|
      u.permit(
        :role, :email, :password, :password_confirmation,
        intern_profile_attributes: [
          :first_name, :last_name, :avatar,
          listing_attributes: [
            :category_id
          ]
        ],
        startup_profile_attributes: [
          :company_name,
          :company_website,
          :avatar
        ]
      )
    }
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    resource.profile_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
