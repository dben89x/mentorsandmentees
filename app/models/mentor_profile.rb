class StartupProfile < ActiveRecord::Base
  include Profile
  extend FriendlyId
  friendly_id :company_name
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '128x128#' }, default_url: '/images/:style/missing.jpg'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
	# validates_attachment_content_type :avatar, content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/


  has_many :listings, as: :listable, dependent: :destroy
  validates :company_name, :company_website, :avatar, presence: true
  validates :company_website, url: true

  def self.csv_only
    [
      :company_name, :email,
      :company_website, :sign_in_count,
      :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip,
      :last_sign_in_ip, :role
    ]
  end

  def name
    company_name
  end

  def startup?
    true
  end

  def intern?
    false
  end

  def looking_for
    'InternProfile'
  end

  def website_link
    company_website
  end

  def path
    Rails.application.routes.url_helpers.startup_profile_path(self)
  end

  private

  def should_generate_new_friendly_id?
    slug.blank? || company_name_changed?
  end
end
