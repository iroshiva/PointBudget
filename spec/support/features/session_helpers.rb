# frozen_string_literal: true

module Features
  module SessionHelpers
    def sign_up_with(email, password)
      visit new_user_registration_path
      fill_in 'Email', with: email
      fill_in 'Mot de passe', with: password
      fill_in 'Confirmer votre mot de passe', with: password
      click_button 'S\'inscrire'
    end

    def sign_in(email, password)
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: email
        fill_in 'Mot de passe', with: password
        click_button 'Se connecter'
      end
    end
  end
end
