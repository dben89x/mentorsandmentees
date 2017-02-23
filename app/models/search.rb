class Search
  include FormForable

  attr_reader :skill_list, :hours_per_week, :location_id, :category_id

  def initialize(role, params = {})
    @listings = default_scope(role)
    assign_params Hash(params)
  end

  def results
    scope = listings
    scope = scope.by_skills(skill_list) if skill_list.present?
    scope = scope.by_hours_per_week(hours_per_week) if hours_per_week.present?
    scope = scope.by_location(location_id) if location_id.present?
    scope = scope.by_category(category_id) if category_id.present?
    scope.by_newest
  end

  private

  attr_reader :listings

  def default_scope(role)
    return Listing.all unless role

    Listing.where(listable_type: role, active: true)
  end

  def assign_params(params)
    @skill_list     = params[:skill_list]
    @hours_per_week = params[:hours_per_week]
    @location_id    = params[:location_id]
    @category_id    = params[:category_id]
  end
end
