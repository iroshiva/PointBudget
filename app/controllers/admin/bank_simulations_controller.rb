# frozen_string_literal: true

module Admin
  class BankSimulationsController < ApplicationController
    def show
      @bank_sim = BankSimulation.find(params[:id])
      @user = @bank_sim.user
      @bank_contracts = @bank_sim.sort_contracts(@bank_sim.join_table_bank_contracts.length)
    end
  end
end