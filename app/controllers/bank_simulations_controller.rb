# frozen_string_literal: true

class BankSimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?
  before_action :not_other_users_bank_simulations, only: [:show]

  def show
    @bank_sim = BankSimulation.find(params[:id])
    @bank_contracts = @bank_sim.sort_contracts(3)
  end

  def create
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    @bank_simulation = BankSimulation.new
    my_params = params[:bank_simulation]
    comparison = @bank_simulation.comparison(my_params[:accounting_fees].to_f, my_params[:price_cheque].to_f, my_params[:insurance_payment].to_f)
    @bank_simulation = BankSimulation.new(bank_cost_saved: comparison[0],
                                          accounting_fees: my_params[:accounting_fees].to_f,
                                          price_cheque: my_params[:price_cheque].to_f,
                                          insurance_payment: my_params[:insurance_payment].to_f,
                                          full_simulation: @full_simulation)

    if @bank_simulation.save
      @bank_simulation.create_join_table_bank(comparison[1], comparison[2])
      @full_simulation.update(total_cost_saved: (@full_simulation.total_cost_saved + @bank_simulation.bank_cost_saved),
                              counter: @full_simulation.counter + 1)
      respond_to do |format|
        format.html { redirect_to user_full_simulation_path(current_user, @full_simulation) }
        format.js { }
      end
    else
      flash[:error] = "Veuillez remplir tous les champs pour terminer la simulation d'offre internet"
    end
  end
end
