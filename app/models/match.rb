class Match < ActiveRecord::Base
  validates :matchable_id, :matched_with, presence: true
  belongs_to :matchable, polymorphic: true

  delegate :name, :position_name, to: :matchable

  def self.by_date
    order(:created_at)
  end

  def to_s
    if intern_match?
      "(INTERN) #{name} matched with startup: #{matched_with} on #{created_at.to_date.to_s(:long)}"
    else
      "(STARTUP) #{name} filled their listing `#{position_name}` with: #{matched_with} on #{created_at.to_date.to_s(:long)}"
    end
  end

  private

  def intern_match?
    matchable_type == "InternProfile"
  end
end
