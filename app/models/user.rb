class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :startup_profile, dependent: :destroy
  has_one :intern_profile, dependent: :destroy

  accepts_nested_attributes_for :startup_profile
  accepts_nested_attributes_for :intern_profile

  has_one :listing, through: :intern_profile
  has_many :listings, through: :startup_profile

  # has_one :category, through: :profile
  # has_one :location, through: :profile

  delegate :first_name,  :last_name, :category_name, :linked_in,
    :location, :hours_per_week, :active?, :company_name, :company_website,
    to: :profile

  delegate :path, to: :profile, prefix: true

  def profile
    return nil if admin?

    self.send(:"#{role}_profile")
  end

  def admin?
    role == 'admin'
  end
end
