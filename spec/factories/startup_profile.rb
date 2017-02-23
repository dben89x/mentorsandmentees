FactoryGirl.define do
  factory :startup_profile do
    company_name "Monster's Inc"
    company_website 'http://www.monsters-inc.com'
    association :user
  end
end
