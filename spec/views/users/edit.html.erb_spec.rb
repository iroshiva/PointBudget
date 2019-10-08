# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/edit.html.erb', type: :view do
  before :each do
    @user = create(:user)
    3.times { create(:city) }
    @cities = City.all
    sign_in @user
    render
  end
  it "displays 'Editer mon Profile'" do
    expect(rendered).to have_content 'Editer mon profil'
  end
  it 'displays the name' do
    expect(rendered).to have_content 'Votre nom'
  end
  it 'displays the phone number' do
    expect(rendered).to have_content 'Votre numéro de téléphone'
  end
  it 'displays the city field' do
    expect(rendered).to have_content 'Votre ville'
  end
end
