FactoryGirl.define do
  factory :intern_profile do
    first_name 'Monster'
    last_name 'Joe'
    linked_in 'http://www.homestarrunner.com'
    association :user
  end

  factory :intern_mike_profile, parent: :intern_profile do
    first_name 'Mike'
    last_name 'Wazowski'
    linked_in 'http://www.mikes-scares.com'
  end

  factory :intern_sully_profile, parent: :intern_profile do
    first_name 'James'
    last_name 'Sullivan'
    linked_in 'http://www.sully-scares.com'
  end
end
