module Features
  module UsersHelpers

    def create_mike_intern
      mike_user = FactoryGirl.create(:intern)
      mike_profile = FactoryGirl.create(:intern_mike_profile, user: mike_user)
      FactoryGirl.create(
        :intern_mike_listing,
        listable: mike_profile,
        location: Location.find_by_city('Monstropolis'),
        category: Category.find_by_name('Scarer')
      )

      mike_profile
    end

    def create_sully_intern
      sully_user = FactoryGirl.create(:intern)
      sully_profile = FactoryGirl.create(:intern_sully_profile, user: sully_user)
      FactoryGirl.create(
        :intern_sully_listing,
        listable: sully_profile,
        location: Location.find_by_city('Boulder'),
        category: Category.find_by_name('Scarer')
      )

      sully_profile
    end

    def create_monsters_inc_startup
      monster_user = FactoryGirl.create(:startup)
      monster_profile = FactoryGirl.create(:startup_profile, user: monster_user)
      FactoryGirl.create(
        :startup_junior_listing,
        listable: monster_profile,
        location: Location.find_by_city('Monstropolis'),
        category: Category.find_by_name('Scarer')
      )
      FactoryGirl.create(
        :startup_senior_listing,
        listable: monster_profile,
        location: Location.find_by_city('Denver'),
        category: Category.find_by_name('Scarer')
      )

      monster_profile
    end

    def sign_in_as(user)
      visit root_url
      click_link 'Sign in'

      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      submit_form
    end

    def create_categories
      FactoryGirl.create(:category, name: 'Scarer')
      FactoryGirl.create(:category, name: 'Developer')
      FactoryGirl.create(:category, name: 'Designer')
    end

    def create_locations
      FactoryGirl.create(
        :location,
        city: 'Monstropolis',
        state: 'Monstorado',
        state_abbreviation: 'MO'
      )

      FactoryGirl.create(
        :location,
        city: 'Boulder',
        state: 'Colorado',
        state_abbreviation: 'CO'
      )

      FactoryGirl.create(
        :location,
        city: 'Denver',
        state: 'Colorado',
        state_abbreviation: 'CO'
      )
    end
  end
end
