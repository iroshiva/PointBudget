class CreateEleContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :ele_contracts do |t|
      t.string :supplier
      t.string :offer_name
      t.integer :kVA_power
      t.float :subscription_base_price_month
      t.float :kwh_price_base
      t.timestamps
    end
  end
end
