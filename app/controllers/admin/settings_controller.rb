class Admin::SettingsController < ApplicationController
  before_filter :authenticate_user!, :ensure_admin
  before_action :get_setting, only: [:update]

  # todo: not sure what direction these settings will take, but they could
  # be more general. Right now just a toggle
  def update
    @setting.value = !@setting.value

    @setting.save
    head 200, content_type: "text/html"
  end

  def get_setting
    @setting = Setting.find_by(var: params[:id]) || Setting.new(var: params[:id])
  end
end
