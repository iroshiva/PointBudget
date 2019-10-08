# frozen_string_literal: true

class CreateGasContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :gas_contracts do |t|
      t.string :supplier
      t.string :offer_name
      t.integer :kw_consumption_per_year
      t.float :subscription_base_price_month
      t.float :kwh_price_base
      t.timestamps
    end
  end
end
