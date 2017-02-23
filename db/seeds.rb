Category.where(name: 'Developer').first_or_create
Category.where(name: 'Designer').first_or_create

Location.where(city: 'Boulder', state: 'Colorado', state_abbreviation: 'CO').first_or_create
Location.where(city: 'Denver', state: 'Colorado', state_abbreviation: 'CO').first_or_create
Location.where(city: 'Longmont', state: 'Colorado', state_abbreviation: 'CO').first_or_create

admin = User.find_by_email('admin@example.com')
unless admin
  User.create(
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: 'admin',
  )
end

Fabricate.times(10, :intern)
Fabricate.times(10, :startup)
