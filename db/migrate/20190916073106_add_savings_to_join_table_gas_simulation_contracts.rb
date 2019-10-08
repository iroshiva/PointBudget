# frozen_string_literal: true

class AddSavingsToJoinTableGasSimulationContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :join_table_gas_simulation_contracts, :savings, :float, default: 0.00
  end
end
