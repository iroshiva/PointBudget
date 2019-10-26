# frozen_string_literal: true

class GasSimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?
  before_action :not_other_users_gas_simulations, only: [:show]

  def show
    @gas_sim = GasSimulation.find(params[:id])
    table_attributes = @gas_sim.print_report
    @floor_space = table_attributes[0]
    @heat_type = table_attributes[1]
    @water_cooking_type = table_attributes[2]
    @residents_number = table_attributes[3]
    @isolation_type = table_attributes[4]
    @gas_contracts = @gas_sim.sort_contracts(3)
  end

  def create
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    @gas_simulation = GasSimulation.new
    estimation = @gas_simulation.estimation(params[:yearly_cost],
                                            params[:yearly_consumption],
                                            params[:floor_space],
                                            params[:heat_type],
                                            params[:water_cooking_type],
                                            params[:nb_residents],
                                            params[:isolation_type])
    comparison = estimation[0] == false ? [-1, false] : @gas_simulation.comparison(estimation[0], estimation[1])
    @gas_simulation = GasSimulation.new(actual_price_paid: params[:yearly_cost],
                                        gas_cost_saved: comparison[0],
                                        floor_space: params[:floor_space],
                                        heat_type: params[:heat_type],
                                        water_cooking_type: params[:water_cooking_type],
                                        residents_number: params[:nb_residents],
                                        gas_use: estimation[1],
                                        full_simulation: @full_simulation,
                                        isolation_type: params[:isolation_type])

    # if @gas_simulation.save
    #   @gas_simulation.create_join_table_gas(comparison[1], comparison[2])
    #   @full_simulation.update(total_cost_saved: (@full_simulation.total_cost_saved + @gas_simulation.gas_cost_saved),
    #                           counter: @full_simulation.counter + 1)
    #   flash[:success] = 'Votre simulation de gaz a bien été enregistrée'
    # else
    #   flash[:error] = 'Veuillez remplir tous les champs pour terminer la simulation de gaz'
    # end
    if @gas_simulation.save
      @gas_simulation.create_join_table_gas(comparison[1], comparison[2])
      @full_simulation.update(total_cost_saved: (@full_simulation.total_cost_saved + @gas_simulation.gas_cost_saved),
                              counter: @full_simulation.counter + 1)
      respond_to do |format|
        format.html { redirect_to user_full_simulation_path(current_user, @full_simulation) }
        format.js { }
      end
   
    else
      flash[:error] = 'Veuillez remplir tous les champs pour terminer la simulation de gaz'
    end
   
  end
end


    