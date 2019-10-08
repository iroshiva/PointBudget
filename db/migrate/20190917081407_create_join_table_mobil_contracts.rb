class CreateJoinTableMobilContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :join_table_mobil_contracts do |t|
      t.float :savings, default: 0.00
      t.belongs_to :mobil_simulation, index: true
			t.belongs_to :mobil_contract, index: true
      t.timestamps
    end
  end
end
