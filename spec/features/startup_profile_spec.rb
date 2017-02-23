require 'rails_helper'

feature 'user accounts' do
  background do
    create_categories
    create_locations
  end

  flow 'Edit Startup profile' do
    step 'visit profile' do
      create_startup_account

      click_link 'My Profile'
      expect(page).to have_content 'WWE'
      expect(page).not_to have_updated_startup_profile
    end

    step 'edit profile' do
      click_link 'Edit Profile'

      fill_in 'Company website', with: 'http://www.tunnelsnakes.com'
      submit_form

      expect(page).to have_updated_startup_profile
    end
  end

  def have_updated_startup_profile
    have_content 'Startup Website http://www.tunnelsnakes.com'
  end

  def create_startup_account
    visit root_path
    click_link 'Find an Intern', match: :prefer_exact

    fill_in 'Company name',          with: 'WWE'
    fill_in 'Company website',       with: 'http://www.johncena.com'
    fill_in 'Email',                 with: 'trumpet@example.com'
    fill_in 'Password',              with: 'password'
    fill_in 'Password Confirmation', with: 'password'

    submit_form
  end
end
