class AddColumnIsolationTypeInGasSimulation < ActiveRecord::Migration[5.2]
  def change
  	add_column :gas_simulations, :isolation_type, :string
  end
end
