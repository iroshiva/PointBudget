# frozen_string_literal: true

module Admin
  class MobilSimulationsController < ApplicationController
    def show
      @mobil_simulation = MobilSimulation.find(params[:id])
      @user = @mobil_simulation.user
      @mobil_contracts = @mobil_simulation.sort_contracts(@mobil_simulation.join_table_mobil_contracts.length)
    end
  end
end