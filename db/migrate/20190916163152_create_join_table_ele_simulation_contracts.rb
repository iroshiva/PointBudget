class CreateJoinTableEleSimulationContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :join_table_ele_simulation_contracts do |t|
      t.float :savings, :float, default: 0.00
      t.belongs_to :ele_simulation, index: true
      t.belongs_to :ele_contract, index: true
      t.timestamps
    end
  end
end
