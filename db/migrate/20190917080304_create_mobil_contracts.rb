class CreateMobilContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :mobil_contracts do |t|
      t.string :supplier
      t.string :offer_name
      t.integer :line_service_price, default: 0
      t.integer :sim_card_price, default: 0
      t.boolean :engagement, default: false
      t.boolean :add_phone, default: false
      t.float :bundle_price, default: 0.00
      t.float :bundle_gbyte, default: 0.00
      t.boolean :calls_france, default: false
      t.boolean :calls_europe, default: false
      t.float :gbyte_europe, default: 0.00
      t.boolean :calls_international, default: false
      t.boolean :net_international, default: false

      t.timestamps
    end
  end
end
