Fabricator(:listing) do
  location_id    { Location.all.sample.id }
  category_id    { Category.all.sample.id }
  hours_per_week { [10, 20, 30, 40].sample }
  active         { true }
  skill_list     { %w(poetry HTML CSS Rails Ruby Photoshop Word Excel pugs Sketch).sample(rand(5)) }
  description    { Faker::Lorem.paragraph }

  position_name  { Faker::Name.title }
  posting_link   { Faker::Internet.url }
  contact_name   { Faker::Name.name }
  contact_email  { Faker::Internet.email }
end
