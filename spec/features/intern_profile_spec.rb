require 'rails_helper'

feature 'user accounts' do
  background do
    create_categories
    create_locations
  end

  flow 'Edit Intern profile' do
    step 'visit profile' do
      create_intern_account

      click_link 'My Profile'
      expect(page).to have_content 'John Cena'
      expect(page).not_to have_updated_intern_profile
    end

    step 'edit profile' do
      click_link 'Edit Profile'
      fill_in 'LinkedIn',               with: 'http://www.tunnelsnakes.com'
      select  'Boulder, CO',            from: 'Location'
      fill_in 'Desired hours per week', with: '20'
      fill_in 'Skill list',             with: 'trumpet, doot, wrestling'
      fill_in 'Tell us a little bit about yourself',
        with: 'And his name is JOHN CENA!'
      uncheck 'Public'
      submit_form

      expect(page).to have_updated_intern_profile
    end
  end

  def have_updated_intern_profile
    have_content 'LinkedIn http://www.tunnelsnakes.com'
    have_content 'Location Boulder, CO'
    have_content 'Desired Hours Per Week 20'
    have_content 'Skills trumpet, doot, wrestling'
    have_content 'Description And his name is JOHN CENA!'
    have_content 'Your profile is currently private'
  end

  def create_intern_account
    visit root_path
    click_link 'Find an Internship', match: :first

    fill_in 'First name',            with: 'John'
    fill_in 'Last name',             with: 'Cena'
    select  'Developer',             from: 'Area of Interest'
    fill_in 'Email',                 with: 'doot@example.com'
    fill_in 'Password',              with: 'password'
    fill_in 'Password Confirmation', with: 'password'

    submit_form
  end
end
