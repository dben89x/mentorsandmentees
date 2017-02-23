require 'rails_helper'

feature 'user accounts' do
  background do
    create_categories
    create_locations
  end

  flow 'creating an Intern account' do
    step 'visit sign in page' do
      visit root_path
      click_link 'Find an Internship', match: :first

      expect(page).to have_content 'Congratulations on taking your first step toward a great internship in Colorado!'
    end

    step 'try to sign up without entering info' do
      submit_form

      expect(page).to have_content 'Please review the problems below:'
    end

    step 'try to sign up with complete info' do
      fill_in 'First name',            with: 'John'
      fill_in 'Last name',             with: 'Cena'
      select  'Developer',             from: 'Area of Interest'
      fill_in 'Email',                 with: 'doot@example.com'
      fill_in 'Password',              with: 'password'
      fill_in 'Password Confirmation', with: 'password'

      submit_form

      expect(page).to have_content welcome_message
      expect(page).to have_content 'John Cena'
      expect(page).to have_content 'Intern seeking Developer position'
      expect(page).to have_content 'Email doot@example.com'
    end

    step 'ensure password is correct' do
      click_link 'Log Out'
      expect(page).to have_content 'Signed out successfully.'

      click_link 'Sign in'
      fill_in 'Email', with: 'doot@example.com'
      fill_in 'Password', with: 'password'
      submit_form

      expect(page).to have_content 'Signed in successfully.'
    end

    step 'edit user settings' do
      click_link 'Settings'

      fill_in 'Email', with: 'doot2@example.com'
      fill_in 'Password', with: 'password2'
      fill_in 'Password confirmation', with: 'password2'
      fill_in 'Current password', with: 'password'

      submit_form
      expect(page).to have_content 'Your account has been updated successfully.'
    end

    step 'log into updated account' do
      click_link 'Log Out'
      expect(page).to have_content 'Signed out successfully.'

      click_link 'Sign in'
      fill_in 'Email', with: 'doot2@example.com'
      fill_in 'Password', with: 'password2'
      submit_form

      expect(page).to have_content 'Signed in successfully.'
    end
  end

  flow 'creating a Startup account' do
    step 'visit sign in page' do
      visit root_path
      click_link 'Find an Intern', match: :prefer_exact

      expect(page).to have_content 'Get ready to find that perfect candidate!'
    end

    step 'try to sign up without entering info' do
      submit_form

      expect(page).to have_content 'Please review the problems below:'
    end

    step 'try to sign up with complete info' do
      fill_in 'Company name',          with: 'WWE'
      fill_in 'Company website',       with: 'http://www.johncena.com'
      fill_in 'Email',                 with: 'trumpet@example.com'
      fill_in 'Password',              with: 'password'
      fill_in 'Password Confirmation', with: 'password'

      submit_form

      expect(page).to have_content welcome_message
      expect(page).to have_content 'WWE'
    end

    step 'ensure password is correct' do
      click_link 'Log Out'
      expect(page).to have_content 'Signed out successfully.'

      click_link 'Sign in'
      fill_in 'Email', with: 'trumpet@example.com'
      fill_in 'Password', with: 'password'
      submit_form

      expect(page).to have_content 'Signed in successfully.'
    end

    step 'edit user settings' do
      click_link 'Settings'

      fill_in 'Email', with: 'trumpet2@example.com'
      fill_in 'Password', with: 'password2'
      fill_in 'Password confirmation', with: 'password2'
      fill_in 'Current password', with: 'password'

      submit_form
      expect(page).to have_content 'Your account has been updated successfully.'
    end

    step 'log into updated account' do
      click_link 'Log Out'
      expect(page).to have_content 'Signed out successfully.'

      click_link 'Sign in'
      fill_in 'Email', with: 'trumpet2@example.com'
      fill_in 'Password', with: 'password2'
      submit_form

      expect(page).to have_content 'Signed in successfully.'
    end
  end

  def welcome_message
    'Welcome! You have signed up successfully. Please complete your profile to increase your visibility.'
  end
end
