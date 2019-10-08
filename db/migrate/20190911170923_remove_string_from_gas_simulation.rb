# frozen_string_literal: true

class RemoveStringFromGasSimulation < ActiveRecord::Migration[5.2]
  def change
    remove_column :gas_simulations, :string, :string
  end
end
