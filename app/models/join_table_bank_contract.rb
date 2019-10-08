class JoinTableBankContract < ApplicationRecord
  belongs_to :bank_contract
  belongs_to :bank_simulation
end
