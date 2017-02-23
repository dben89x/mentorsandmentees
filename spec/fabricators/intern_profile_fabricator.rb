Fabricator(:intern_profile) do
  first_name { Faker::Name.first_name }
  last_name  { Faker::Name.last_name }
  linked_in  { Faker::Internet.url }

  listing
end
