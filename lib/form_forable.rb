require "active_model"

module FormForable
  extend ActiveModel::Naming
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Validations
    include ActiveModel::Conversion
  end

  def persisted?
    false
  end
end
