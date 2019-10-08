# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :view do
  before :each do
    @user = create(:user)
    sign_in @user
    render
  end
  it "displays 'Mon Profile'" do
    expect(rendered).to have_content 'Mon Profil'
  end
  it 'displays the mail' do
    expect(rendered).to have_content @user.email
  end
  it 'displays have link to edition' do
    expect(rendered).to have_content 'Editer mon profil'
    expect(rendered).to have_content 'Editer mon compte'
  end
end
