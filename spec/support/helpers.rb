module Support
  module Helpers
    def submit_form
      find('input[type="submit"]').click
    end
  end
end
