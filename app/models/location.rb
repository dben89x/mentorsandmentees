class Location < ActiveRecord::Base
  validates :city, :state, :state_abbreviation, presence: true
  validates :state_abbreviation, length: { is: 2 }
  validates :state_abbreviation, format: { with: /\A[A-Z]+\z/, message: "Must be two upper-case letters" }

  def city_and_state
    "#{city}, #{state_abbreviation}"
  end
end
