module Profile
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    delegate :email, :admin?, to: :user
  end
end
