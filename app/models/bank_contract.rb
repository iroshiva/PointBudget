class BankContract < ApplicationRecord
  has_many :join_table_bank_contracts
  has_many :bank_simulations, through: :join_table_bank_contracts
end
