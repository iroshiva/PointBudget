# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'the sign in process', type: :feature do
  before :each do
    User.create(email: 'user@example.com', password: 'password')
  end

  scenario 'signs me in' do
    sign_in('user@example.com', 'password')
    expect(page).to have_content 'Mon Espace Client'
  end

  scenario 'with invalid email' do
    sign_in 'invalid_email', 'password'
    expect(page).to have_content('Se connecter')
  end

  scenario 'with blank password' do
    sign_in 'valid@example.com', ''
    expect(page).to have_content('Se connecter')
  end

  scenario 'with 4 letters password' do
    sign_in 'valid@example.com', 'azer'
    expect(page).to have_content('Se connecter')
  end
end
