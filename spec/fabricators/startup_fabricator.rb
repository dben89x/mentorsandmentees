Fabricator(:startup, from: :user) do
  email                 { Faker::Internet.email }
  password              { 'password' }
  password_confirmation { |attrs| attrs[:password] }
  role                  { 'startup' }
	avatar								{ 'images/people/allan.jpg' }

  startup_profile
end
