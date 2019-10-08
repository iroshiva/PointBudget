# frozen_string_literal: true

class AddCounterToFullSimulation < ActiveRecord::Migration[5.2]
  def change
    add_column :full_simulations, :counter, :integer, default: 0, null: false
  end
end
