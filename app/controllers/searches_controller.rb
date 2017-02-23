class SearchesController < ApplicationController
  before_filter :authenticate_user!, :find_profile

  def index
    @search = Search.new(looking_for, params[:search] || default_search_params)
    # todo: make this default on model? also maybe open issue for includes :taggings
    @results = @search.results.includes(:listable).includes(:category).includes(:location).includes(:taggings)
  end

  private

  def looking_for
    @profile.try(:looking_for) || params[:role]
  end

  def find_profile
    return if current_user.admin?

    @profile = current_profile
  end

  def default_search_params
    return unless @profile.try(:intern?)

    {
      category_id: @profile.category_id,
      location_id: @profile.location_id
    }
  end
end
