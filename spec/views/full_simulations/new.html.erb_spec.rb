# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'full_simulations/new.html.erb', type: :view do
  before :each do
    @user = create(:user)
    sign_in @user
    render
  end

  it "displays 'Factures'" do
    expect(rendered).to have_content 'Munissez-vous des factures trop chères à votre goût!'
  end
  it "displays 'Simulation'" do
    expect(rendered).to have_content 'Je lance ma simulation'
  end
end
