class Admin::MatchesController < ApplicationController
  before_filter :authenticate_user!, :ensure_admin

  add_breadcrumb 'Admin Dashboard', :admin_path
  add_breadcrumb 'Matches', :admin_matches_path

  def index
    @matches = Match.all.by_date
  end
end
