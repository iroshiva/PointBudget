# frozen_string_literal: true

module Admin
  class FullSimulationsController < ApplicationController
    def show
      @full_simulation = FullSimulation.find(params[:id])
      @user = @full_simulation.user
    end
  end
end