class AddNameColumnToEleSimulation < ActiveRecord::Migration[5.2]
  def change
    add_column :ele_simulations, :name, :string, default: "Electricité"
  end
end
