# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Visitor signs up', type: :feature do
  scenario 'with valid email and password' do
    sign_up_with 'valid@example.com', 'password'
    expect(page).to have_content('Mon Espace Client')
  end

  scenario 'with invalid email' do
    sign_up_with 'invalid_email', 'password'
    expect(page).to have_content('S\'inscrire')
  end

  scenario 'with blank password' do
    sign_up_with 'valid@example.com', ''
    expect(page).to have_content('S\'inscrire')
  end
end
