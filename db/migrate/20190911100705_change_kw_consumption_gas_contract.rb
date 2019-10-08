# frozen_string_literal: true

class ChangeKwConsumptionGasContract < ActiveRecord::Migration[5.2]
  def change
    remove_column :gas_contracts, :kw_consumption_per_year, :integer
    add_column :gas_contracts, :low_kw_consumption_per_year, :integer
    add_column :gas_contracts, :high_kw_consumption_per_year, :integer
  end
end
