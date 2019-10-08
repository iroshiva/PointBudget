class BankSimulation < ApplicationRecord
  belongs_to :full_simulation
  has_many :join_table_bank_contracts
  has_many :bank_contracts, through: :join_table_bank_contracts

  validates :bank_cost_saved,
            presence: true,
            numericality: { greater_than_or_equal_to: 0.00 }


  def comparison(accounting_fees, price_cheque, insurance_payment)
    price_paid = accounting_fees + price_cheque + insurance_payment
    first_filter = BankContract.all.select {|contract|
      contract.accounting_fees.to_f + contract.price_cheque.to_f + contract.insurance_payment.to_f < price_paid
    }
    max_save = 0
    all_savings = []
    first_filter.each do |contract|
      price_contract = contract.accounting_fees.to_f + contract.price_cheque.to_f + contract.insurance_payment.to_f
      savings = ((price_paid - price_contract)*12).round(2) # Find the best price
      if savings > max_save
        max_save = savings # Save the best price
      end
      all_savings << savings # Save the differences in an array, it will be use after
    end
    [max_save.round(2), first_filter, all_savings] # return the max savec, all the better contracts and the savings for each contracts
  end

  # This method can show the top best contracts depending on the number we want to show
  def sort_contracts(how_many)
    return_array = []
    contracts_sorted = join_table_bank_contracts.sort_by(&:savings).reverse
    how_many.times do |i|
      return_array << BankContract.find(contracts_sorted[i].bank_contract_id)
    rescue
      return_array
    end
    return_array
  end

  # Set the user of the bank simulation
  def user
    self.full_simulation.user
  end

  # This method create all the join table given by the filter and the saving associated with each
  def create_join_table_bank(filter, all_savings)
    filter.each_with_index do |contract, index|
      JoinTableBankContract.create(bank_simulation: self, bank_contract: contract, savings: all_savings[index])
    end
  end
end