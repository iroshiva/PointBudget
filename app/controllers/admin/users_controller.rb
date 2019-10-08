# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    def index
      @users = User.all.sort_by { |user| user.is_admin ? 0 : 1 }
    end

    def show
      @user = User.find(params[:id])
      @full_sim_non_valid = @user.full_simulations.select { |full_sim| full_sim.validated == false }
      @full_sim_valid = @user.full_simulations.select { |full_sim| full_sim.validated == true }
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(email: params[:user][:email],
                       password: params[:user][:password])
      if @user.save
        flash[:success] = 'User created'
        redirect_to admin_root_path
      else
        redirect_to new_admin_user_path
      end
    end

    def edit
      @user = User.find(params[:id])
      @cities = City.all
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        if @user == current_user
          sign_out current_user
          redirect_to root_path
        else
          redirect_to admin_root_path
        end
      else
        render 'edit'
      end
    end

    def destroy
      @user = User.find(params[:id])

      if @user.is_admin != true
        @user.destroy
        flash[:success] = 'User successfully deleted'
      else
        flash[:error] = "You can't destroy a admin user"
      end
      redirect_to admin_users_path
    end

    private

    def user_params
      params[:user].permit(:first_name, :last_name, :phone_number, :is_admin, :city_id)
    end
  end
end
