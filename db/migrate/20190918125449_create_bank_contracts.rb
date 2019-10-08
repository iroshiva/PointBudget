class CreateBankContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_contracts do |t|
      t.string :supplier, default: ''
      t.string :group_name, default: ''
      t.float :accounting_fees, default: 0.00
      t.float :inactive_accounting_fees, default: 0.00
      t.boolean :cheque, default: true
      t.float :price_cheque, default: 0.00
      t.float :price_order_cheque, default: 0.00
      t.float :insurance_payment, default: 0.00
      t.float :sms_alert, default: 0.00
      t.float :international_withdraw, default: 0.00

      t.timestamps
    end
  end
end
