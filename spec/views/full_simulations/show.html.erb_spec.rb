# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'full_simulations/show.html.erb', type: :view do
  context 'Non validated' do
    before :each do
      @user = create(:user)
      sign_in @user
      @full_simulation = create(:full_simulation, user: @user)
      render
    end
  end

  context 'Validated' do
    before :each do
      @user = create(:user)
      sign_in @user
      @full_simulation = create(:full_simulation, user: @user, validated: true)
      render
    end
    it "displays 'Contacter un conseiller'" do
      expect(rendered).to have_content 'Contacter un conseiller'
    end

  end
end
