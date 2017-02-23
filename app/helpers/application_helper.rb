module ApplicationHelper

  # todo: move this to a before_filter on app controller?
  def current_profile
    @current_profile ||= current_user.try(:profile)
  end

  def flash_for
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }
  end
end
