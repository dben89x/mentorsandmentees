require 'rails_helper'

feature 'user accounts' do
  background do
    create_categories
    create_locations
  end

  given!(:intern_mike)  { create_mike_intern }
  given!(:intern_sully) { create_sully_intern }
  given!(:startup) { create_monsters_inc_startup }

  context 'As an Intern' do
    background do
      sign_in_as(intern_mike)
      click_link 'Search'
    end

    scenario 'view proper default search' do
      expect(page).to have_content 'Search Results'
      expect(page).to have_content 'Found 1 result'
      expect(page).to have_content 'Junior Scarer'
    end

    scenario 'view proper job listing info' do
      expect(page).to have_content 'Junior Scarer'
      expect(page).to have_content "Monster's Inc"
      expect(page).to have_content 'Scarer'
      expect(page).to have_content 'Monstropolis, MO'
      expect(page).to have_content 'roaring, wailing'
      expect(page).to have_content 'Learn to scare with the best of them'
      expect(page).to have_content 'View'
    end

    flow 'filter job listings' do
      step 'filter by all locations' do
        select '- Select A Location -', from: 'Location'
        submit_form

        expect(page).to have_content 'Found 2 results'
        expect(page).to have_content 'Junior Scarer'
        expect(page).to have_content 'Senior Scarer'
      end

      step 'filter by specific location' do
        select 'Denver, CO', from: 'Location'
        submit_form

        expect(page).to have_content 'Found 1 result'
        expect(page).to have_content 'Senior Scarer'
      end

      step 'filter by category' do
        select 'Developer', from: 'Category'
        submit_form

        expect(page).to have_content 'Found 0 results'
      end

      step 'filter by skills' do
        select 'Scarer', from: 'Category'
        select '- Select A Location -', from: 'Location'
        fill_in 'Skill list', with: 'roaring'
        submit_form

        expect(page).to have_content 'Found 2 results'
        expect(page).to have_content 'Junior Scarer'
        expect(page).to have_content 'Senior Scarer'
      end

      step 'filter by another skill' do
        fill_in 'Skill list', with: 'wailing'
        submit_form

        expect(page).to have_content 'Found 1 result'
        expect(page).to have_content 'Junior Scarer'
      end

      step 'filter by hours per week' do
        fill_in 'Skill list', with: ''
        fill_in 'Hours per week', with: '40'
        submit_form

        expect(page).to have_content 'Found 1 result'
        expect(page).to have_content 'Senior Scarer'
      end

      step 'filter by a different amount of hours per week' do
        fill_in 'Hours per week', with: '20'
        submit_form

        expect(page).to have_content 'Found 1 result'
        expect(page).to have_content 'Junior Scarer'
      end
    end

    scenario 'view the show page for a job posting' do
      click_link 'View'

      expect(page).to have_content 'Junior Scarer'
      expect(page).to have_content "Startup Monster's Inc"
      expect(page).to have_content 'Posting Link http://www.tunnelsnakes.com'
      expect(page).to have_content 'Startup Website http://www.monsters-inc.com'
      expect(page).to have_content 'Contact Name Henry Waternoose'
      expect(page).to have_content 'Contact Email waternoose@example.com'
    end
  end
end
