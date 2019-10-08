# frozen_string_literal: true

class CreateGasSimulations < ActiveRecord::Migration[5.2]
  def change
    create_table :gas_simulations do |t|
      t.float :actual_price_paid
      t.float :gas_cost_saved
      t.integer :floor_space
      t.string :heat_type
      t.string :string
      t.string :water_cooking_type
      t.integer :residents_number
      t.integer :gas_use
      t.belongs_to :full_simulation, index: true

      t.timestamps
    end
  end
end
