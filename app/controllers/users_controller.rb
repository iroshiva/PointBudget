# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!
  before_action :not_other_user

  def show
    return if current_user.id == @user.id

    flash[:error] = "Vous n'avez pas le droit d'accéder à cette page"
    redirect_to user_path(current_user)
  end

  def edit
    @cities = City.all
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Votre profil vient d'être édité avec succès!"
      redirect_to user_path(@user.id)
    else
      flash[:error] = "Votre profil n'a pas pu être édité..."
      render :edit
    end
  end

  private

  def user_params
    change_city
    params.require(:user).permit(:first_name, :last_name, :phone_number, :city_id)
  end

  def set_user
    @user = begin
              User.find(params[:id])
            rescue
              User.all.sample
            end
  end

  def change_city
    return if params[:user][:city_id].empty?

    city = params[:user][:city_id]
    table = city.split(' - ')
    the_city = City.find_by(name: table[1])
    params[:user][:city_id] = the_city.id unless the_city.nil?
  end
end
