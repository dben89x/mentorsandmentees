class InternProfile < ActiveRecord::Base
  include Profile
  extend FriendlyId
  friendly_id :full_name
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '128x128#' }, default_url: '/images/:style/missing.jpg'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
	# validates_attachment_content_type :avatar, content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/

  belongs_to :user
  has_one :listing, as: :listable, dependent: :destroy
  has_one :location, through: :listing
  has_one :category, through: :listing
  has_many :matches, as: :matchable

  validates :first_name, :last_name, :avatar, presence: true
  validates :linked_in, url: true, allow_blank: true

  accepts_nested_attributes_for :listing

  delegate :category_name, :location, :hours_per_week, :active?, :skill_list,
    :category_id, :location_id, :description, :deactivate!, to: :listing

  def self.csv_only
    [
      :first_name, :last_name, :email, :active, :name, :city,
      :description, :hours_per_week, :linked_in, :sign_in_count,
      :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip,
      :last_sign_in_ip, :role
    ]
  end

  def name
    first_name
  end

  def full_name
    [first_name, last_name].map(&:capitalize).join(' ')
  end

  # todo: move to a presenter
  def purpose
    "Intern seeking #{category_name.capitalize} position"
  end

  def website_link
    linked_in
  end

  def startup?
    false
  end

  def intern?
    true
  end

  def looking_for
    'StartupProfile'
  end

  def path
    Rails.application.routes.url_helpers.intern_profile_path(self)
  end

  private

  def should_generate_new_friendly_id?
    slug.blank? || first_name_changed? || last_name_changed?
  end
end
