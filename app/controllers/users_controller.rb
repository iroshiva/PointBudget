class UsersController < ApplicationController

  before_action :set_user, only:[:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    unless current_user.id == @user.id
      flash[:error] = "Vous n'avez pas le droit d'accéder au profil d'autres utilisateurs!!"
      redirect_to user_path(current_user)
    end
  end

  def new
  end

  def create
  end

  def edit
    @cities = City.all
    @city = @user.city
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

  def destroy
  end

  private

  def user_params
    city = params[:user][:city_id]
    puts "#"*60
    puts city
    binding.pry
    table = city.split(' - ')
    the_city = City.find_by(name: table[1])
    params[:user][:city_id] = the_city.id
    params.require(:user).permit(:first_name, :last_name, :phone_number, :city_id)
  end

  def set_user
    @user = User.find(params[:id])
  end


end
