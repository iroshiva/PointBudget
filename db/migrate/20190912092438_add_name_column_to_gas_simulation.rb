# frozen_string_literal: true

class AddNameColumnToGasSimulation < ActiveRecord::Migration[5.2]
  def change
    add_column :gas_simulations, :name, :string, default: "Gaz"
  end
end
