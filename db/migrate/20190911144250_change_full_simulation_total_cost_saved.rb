# frozen_string_literal: true

class ChangeFullSimulationTotalCostSaved < ActiveRecord::Migration[5.2]
  def change
    change_column :full_simulations, :total_cost_saved, :float, null: false, default: 0
  end
end
