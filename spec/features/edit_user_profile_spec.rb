# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Edit User Profile', type: :feature do
  before :each do
    @user = User.create(email: 'user@example.com', password: 'password')
    sign_in @user.email, @user.password
  end

  scenario 'can edit his profile with correct things' do
    within('#sidenav') do
      click_link 'Mon profil'
    end
    within('#body_content_user') do
      click_link 'Editer mon profil'
    end
    find_field('user_last_name').set('Last')
    find_field('user_first_name').set('First')
    click_button 'Editer'
    within('#body_content_user') do
      expect(page).to have_content('Last')
      expect(page).to have_content('First')
    end
  end
end
