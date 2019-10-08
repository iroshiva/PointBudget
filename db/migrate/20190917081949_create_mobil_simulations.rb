class CreateMobilSimulations < ActiveRecord::Migration[5.2]
  def change
    create_table :mobil_simulations do |t|
      t.string :name, default: "Mobile"
      t.float :actual_price_paid, default: 0.00
      t.float :mobil_cost_saved, default: 0.00
      t.boolean :engagement, default:false
      t.boolean :calls_europe, default: false
      t.boolean :calls_international, default: false
      t.boolean :net_international, default: false
      t.float :bundle_go, default: 0.00
      t.belongs_to :full_simulation, index: true
      t.timestamps
    end
  end
end
