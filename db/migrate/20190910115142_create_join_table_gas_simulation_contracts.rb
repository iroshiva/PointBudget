# frozen_string_literal: true

class CreateJoinTableGasSimulationContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :join_table_gas_simulation_contracts do |t|
      t.belongs_to :gas_simulation, index: true
      t.belongs_to :gas_contract, index: true
      t.timestamps
    end
  end
end
