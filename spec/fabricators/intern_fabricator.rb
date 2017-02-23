Fabricator(:intern, from: :user) do
  email                 { Faker::Internet.email }
  password              { 'password' }
  password_confirmation { |attrs| attrs[:password] }
  role                  { 'intern' }
	avatar								{ 'images/people/allan.jpg' }

  intern_profile
end
