require 'rails_helper'

feature 'Search', type: :feature do
  scenario 'without data' do
    visit root_path
    within 'h1' do
      expect(page).to have_content 'Arnold Clark Car Images'
    end
    click_button 'Show images'
    within '#images' do
      expect(page).to have_content "Registration can't be blank"
      expect(page).to have_content "Registration is too short (minimum is 7 characters)"
      expect(page).to have_content "Reference can't be blank"
      expect(page).to have_content "Reference is too short (minimum is 9 characters)"
    end
  end
  scenario 'with wrong registration number and without reference number' do
    visit root_path
    fill_in 'image_registration', with: '1'
    click_button 'Show images'
    within '#images' do
      expect(page).to have_content "Registration is too short (minimum is 7 characters)"
      expect(page).to have_content "Reference can't be blank"
      expect(page).to have_content "Reference is too short (minimum is 9 characters)"
    end
  end
  scenario 'with good registration number and without reference number' do
    visit root_path
    fill_in 'image_registration', with: ' 1 2 3 4 5 6 7 8  '
    click_button 'Show images'
    within '#images' do
      expect(page).to have_content "Reference can't be blank"
      expect(page).to have_content "Reference is too short (minimum is 9 characters)"
    end
  end
  scenario 'with good registration number and with wrong reference number' do
    visit root_path
    fill_in 'image_registration', with: 'GY12AVK'
    fill_in 'image_reference', with: 'GY12AVK'
    click_button 'Show images'
    within '#images' do
      expect(page).to have_content 'Reference is too short (minimum is 9 characters)'
    end
  end
  scenario 'with good registration number and with good reference number' do
    visit root_path
    fill_in 'image_registration', with: 'GY12AVK'
    fill_in 'image_reference', with: ' G Y 1 2 A V K  2 3 4'
    click_button 'Show images'
    within '#images' do
      expect(page).to_not have_content 'Reference is too short (minimum is 9 characters)'
      expect(all('img').length).to eql 12
    end
  end
end
