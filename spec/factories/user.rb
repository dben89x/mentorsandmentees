FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password 'password'
  end

  factory :intern, parent: :user do
    role 'intern'
  end

  factory :startup, parent: :user do
    role 'startup'
  end
end
