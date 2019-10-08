# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'no-reply@pointbudget.fr'

  def welcome_email(user)
    @user = user
    @url  = 'https://point-budget.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Bienvenue chez nous !')
  end

  def goodbye_email(user)
    @user =  user
    @url  = 'https://point-budget.herokuapp.com/users/sign_up'
    mail(to: @user.email, subject: 'Bonne route pour la suite')
  end

  def simulation_validated_email(user)
    @user = user
    @url = 'https://point-budget.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Vous venez de valider une simulation de budget !')
  end

  def contact_counselour_email(user)
    @user = user
    mail(to: 'pointbudget.thp@gmail.com', subject: 'Un utilisateur demande un rdv')
  end
end
