class CreateJoinTableBankContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :join_table_bank_contracts do |t|
      t.float :savings, default: 0.00
      t.belongs_to :bank_simulation, index: true
      t.belongs_to :bank_contract, index: true

      t.timestamps
    end
  end
end
