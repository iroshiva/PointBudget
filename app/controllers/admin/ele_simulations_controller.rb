# frozen_string_literal: true

module Admin
  class EleSimulationsController < ApplicationController
    def show
      @ele_sim = EleSimulation.find(params[:id])
      @user = @ele_sim.user
      @ele_contracts = @ele_sim.sort_contracts(@ele_sim.join_table_ele_simulation_contracts.length)
    end
  end
end