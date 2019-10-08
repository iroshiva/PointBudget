class CreateBankSimulations < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_simulations do |t|
      t.float :bank_cost_saved, default: 0.00
      t.float :accounting_fees, default: 0.00
      t.float :inactive_accounting_fees, default: 0.00
      t.float :price_cheque, default: 0.00
      t.float :insurance_payment, default: 0.00
      t.float :sms_alert, default: 0.00
      t.float :international_withdraw, default: 0.00
      t.string :name, default: 'Banque'
      t.belongs_to :full_simulation, index: true

      t.timestamps
    end
  end
end
