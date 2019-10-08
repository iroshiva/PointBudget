class CreateBoxSimulations < ActiveRecord::Migration[5.2]
  def change
    create_table :box_simulations do |t|
      t.float :actual_price_paid, default: 0.0
      t.float :box_cost_saved, default: 0.0
      t.boolean :tv, default: :false
      t.boolean :call_fix_fr, default: :false
      t.boolean :call_mob_fr, default: :false
      t.string "name", default: "Box Internet"
      t.belongs_to :full_simulation, index: true
      t.timestamps
    end
  end
end
