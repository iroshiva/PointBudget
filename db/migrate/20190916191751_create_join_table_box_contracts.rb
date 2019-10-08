class CreateJoinTableBoxContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :join_table_box_contracts do |t|
      t.float :savings
      t.belongs_to :box_contract, index:true
      t.belongs_to :box_simulation, index:true
      t.timestamps
    end
  end
end
