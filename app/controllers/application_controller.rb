# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_cookie_user
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  # Redirect after the sign in
  def after_sign_in_path_for(resource)
    if current_user.is_admin?
      stored_location_for(resource) || admin_root_path
    else
      stored_location_for(resource) || new_user_full_simulation_path(current_user)
    end
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  rescue
    render_404
  end

  private

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  # This method allows us to know a user is connected or not to avoid errors in js
  def set_cookie_user
    cookies[:username] = current_user.nil? ? 'guest' : current_user.email
  end

  def not_other_user
    # This method prevents users from going to another user's show and edit pages
    return unless current_user != User.find(params[:id])

    error_connected
  end

  def not_other_user_index
    # This method prevents users from going to another index page of an other user
    return unless current_user != User.find(params[:user_id])
  rescue
    error_connected
  end

  def not_other_users_full_simulations
    # This method prevents users from going to pages associated with another user, namely the full simulations
    return unless current_user != FullSimulation.find(params[:id]).user && current_user.has_full_simulations(params[:id])
  rescue
    error_connected
  end

  def not_other_users_gas_simulations
    # This method prevents users from going to pages associated with another user, namely the gas simulations
    return unless current_user != GasSimulation.find(params[:id]).user && current_user.has_gas_simulations(params[:id])
  rescue
    error_connected
  end

  def not_other_users_box_simulations
    # This method prevents users from going to pages associated with another user, namely the box simulations
    return unless current_user != BoxSimulation.find(params[:id]).user && current_user.has_box_simulations(params[:id])
  rescue
    error_connected
  end

  def not_other_users_bank_simulations
    # This method prevents users from going to pages associated with another user, namely the bank simulations
    return unless current_user != BankSimulation.find(params[:id]).user && current_user.has_bank_simulations(params[:id])

  rescue
    error_connected
  end

  def not_other_users_mobil_simulations
    # This method prevents users from going to pages associated with another user, namely the mobile simulations
    return unless current_user != MobilSimulation.find(params[:id]).user && current_user.has_mobil_simulations(params[:id])
  rescue
    error_connected
  end

  def not_other_users_ele_simulations
  # This method prevents users from going to pages associated with another user, namely the electricity simulations
  return unless current_user != EleSimulation.find(params[:id]).user && current_user.has_ele_simulations(params[:id])
  rescue
    error_connected
  end

  def error_connected
    flash[:error] = "Vous n'avez pas le droit d'accéder à cette page"
    redirect_to new_user_full_simulation_path(current_user)
  end
end
