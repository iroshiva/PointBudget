# frozen_string_literal: true

class BoxSimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?
  before_action :not_other_users_box_simulations, only: [:show]

  def show
    @box_sim = BoxSimulation.find(params[:id])
    table_attributes = @box_sim.print_report
    @tv = table_attributes[0]
    @call_fix_fr = table_attributes[1]
    @call_mob_fr = table_attributes[2]
    @box_contracts = @box_sim.sort_contracts(3)
  end


  def create
    @full_simulation = FullSimulation.find(params[:full_simulation_id])
    @box_simulation = BoxSimulation.new
    my_params = params[:box_simulation]
    tv = my_params[:tv] == 'true' ? true : false
    call_fix_fr = my_params[:call_fix_fr] == 'true' ? true : false
    call_mob_fr = my_params[:call_mob_fr] == 'true' ? true : false
    comparison = @box_simulation.comparison(params[:monthly_cost], tv, call_fix_fr, call_mob_fr)
    @box_simulation = BoxSimulation.new(actual_price_paid: params[:monthly_cost],
                                        box_cost_saved: comparison[0],
                                        tv: tv,
                                        call_fix_fr:call_fix_fr,
                                        call_mob_fr:call_mob_fr,
                                        full_simulation: @full_simulation)

    if @box_simulation.save
      @box_simulation.create_join_table_box(comparison[1], comparison[2])
      @full_simulation.update(total_cost_saved: (@full_simulation.total_cost_saved + @box_simulation.box_cost_saved),
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
