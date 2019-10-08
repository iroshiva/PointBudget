# frozen_string_literal: true

module Admin
  class GasSimulationsController < ApplicationController
    def show
      @gas_sim = GasSimulation.find(params[:id])
      @user = @gas_sim.user
      table_attributes = @gas_sim.print_report
      @floor_space = table_attributes[0]
      @heat_type = table_attributes[1]
      @water_cooking_type = table_attributes[2]
      @residents_number = table_attributes[3]
      @gas_contracts = @gas_sim.sort_contracts(@gas_sim.join_table_gas_simulation_contracts.length)
    end
  end
end