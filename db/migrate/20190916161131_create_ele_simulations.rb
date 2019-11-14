class CreateEleSimulations < ActiveRecord::Migration[5.2]
  def change
    create_table :ele_simulations do |t|
      t.float :actual_price_paid
      t.float :ele_cost_saved
      t.integer :floor_space
      t.string :heat_type
      t.string :water_type
      t.string :cooking_type
      t.integer :residents_number
      t.integer :ele_use
      t.belongs_to :full_simulation, index: true
      t.string :isolation_type

      t.timestamps
    end
  end
end
