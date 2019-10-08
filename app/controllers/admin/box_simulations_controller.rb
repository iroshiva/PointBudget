# frozen_string_literal: true

module Admin
  class BoxSimulationsController < ApplicationController
    def show
      @box_sim = BoxSimulation.find(params[:id])
      @user = @box_sim.user
      @box_contracts = @box_sim.sort_contracts(@box_sim.join_table_box_contracts.length)
    end
  end
end