class Listing < ActiveRecord::Base
  extend FriendlyId
  friendly_id :position_name

  acts_as_ordered_taggable_on :skills
  belongs_to :listable, polymorphic: true
  belongs_to :category
  belongs_to :location
  has_many :matches, as: :matchable

  validates :category_id, presence: true
  validates :hours_per_week, inclusion: { in: 1..60, message: "Must be between 1 and 60" }, allow_blank: true
  validates_length_of :description, maximum: 500, allow_blank: true

  validates :position_name, :contact_email, presence: true, if: :job_listing?

  delegate :name, :avatar, :email, :website_link, :path, :full_name, :company_name,
    to: :listable
  delegate :city_and_state, to: :location

  alias :profile :listable

  def self.by_date
    order(:created_at)
  end

  def self.by_newest
    order(created_at: :desc)
  end

  def self.job_listings
    where(listable_type: 'StartupProfile')
  end

  def self.intern_listings
    where(listable_type: 'InternProfile')
  end

  def self.active
    where(active: true)
  end

  def self.by_skills(skills = {})
    tagged_with(skills, any: true)
  end

  def self.by_hours_per_week(hours)
    where(hours_per_week: hours)
  end

  def self.by_location(location)
    where(location: location)
  end

  def self.by_category(category)
    where(category: category)
  end

  def category_name
    Category.find(category.id).name
  end

  def show_link
    job_listing? ? job_path : path
  end

  def job_listing?
    listable_type == 'StartupProfile'
  end

  def active?
    active
  end

  def deactivate!
    update_attribute(:active, false)
  end

  private

  def job_path
    Rails.application.routes.url_helpers.listing_path(self)
  end

  def should_generate_new_friendly_id?
    slug.blank? || position_name_changed?
  end
end
