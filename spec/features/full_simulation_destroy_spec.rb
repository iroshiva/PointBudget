# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Full Simulation Destroy', type: :feature do
  before :each do
    @user = User.create(email: 'user@example.com', password: 'password')
    sign_in @user.email, @user.password
    5.times do
      create(:full_simulation, user: @user, validated: true)
      create(:full_simulation, user: @user)
    end
  end


  scenario 'delete a validated simulation' do
    visit user_full_simulations_path(@user)
    full_sim_id = FullSimulation.where(validated: true).last.id
    within("#simulation-confirmed-#{full_sim_id}") do
      click_link 'Supprimer'
    end
    expect(page).not_to have_content(" #{full_sim_id} ")
  end
end
