FactoryGirl.define do
  factory :listing do
    association :listable
    association :category
    association :location
    active true
    hours_per_week 20
  end

  factory :intern_listing, parent: :listing do
    description 'Ready to become the best scarer in the world!'
  end

  factory :intern_mike_listing, parent: :listing do
    description 'Lean, mean, and totally green!'
    hours_per_week 10
  end

  factory :intern_sully_listing, parent: :listing do
    description 'Big, blue and purple, and fuzzy. OH MY!'
    hours_per_week 30
  end

  factory :startup_junior_listing, parent: :listing do
    position_name 'Junior Scarer'
    posting_link 'http://www.tunnelsnakes.com'
    contact_name 'Henry Waternoose'
    contact_email 'waternoose@example.com'
    description 'Learn to scare with the best of them'
    skill_list 'roaring, wailing'
  end

  factory :startup_senior_listing, parent: :listing do
    position_name 'Senior Scarer'
    posting_link 'http://www.tunnelsnakes.com'
    contact_name 'Roz Slugsworth'
    contact_email 'rozslugsworth@example.com'
    description "You're big, bad, and READY TO SCARE SOME KIDS!"
    skill_list 'roaring, sneaking'
    hours_per_week 40
  end
end
