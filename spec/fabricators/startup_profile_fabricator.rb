Fabricator(:startup_profile) do
  company_name    { Faker::Company.name }
  company_website { Faker::Internet.url }

  listings(rand: 5) { |attrs, i| Fabricate(:listing) }
end
