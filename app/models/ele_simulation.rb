class EleSimulation < ApplicationRecord
  belongs_to :full_simulation
  has_many :join_table_ele_simulation_contracts, dependent: :destroy
  has_many :ele_contracts, through: :join_table_ele_simulation_contracts

  validates :actual_price_paid,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
  validates :ele_cost_saved,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
  validates :ele_use,
            presence: true,
            numericality: { greater_than_or_equal_to: 0, only_integer: true }

  # Set the user of the elec simulation
  def user
    self.full_simulation.user
  end

  # This method execute the comparison between what is entered by the client and the contracts
  def comparison(yearly_cost, yearly_consumption, kVA_power)
    yearly_cost = yearly_cost.to_f
    yearly_consumption = yearly_consumption.to_i
    kVA_power = kVA_power.to_i
    first_filter = EleContract.all.select { |contract| contract.kVA_power == kVA_power }
    second_filter = first_filter.select{ |contract| yearly_cost > (contract.kwh_price_base * yearly_consumption + contract.subscription_base_price_month * 12)}
    max_save = 0
    all_savings = []
    second_filter.each do |contract|
      savings = yearly_cost - (contract.kwh_price_base * yearly_consumption + contract.subscription_base_price_month * 12)
      if savings > max_save
        max_save = savings
      end
      all_savings << savings
    end
    [max_save.round(2), second_filter, all_savings]
  end

  # This method create all the join table given by the filter and the saving associated with each
  def create_join_table_ele(filter, all_savings)
    filter.each_with_index do |contract, index|
      JoinTableEleSimulationContract.create(ele_simulation: self, ele_contract: contract, savings: all_savings[index])
    end
  end

  # This method can show the top best contracts depending on the number we want to show
  def sort_contracts(how_many)
    return_array = []
    contracts_sorted = join_table_ele_simulation_contracts.sort_by(&:savings).reverse
    how_many.times do |i|
      return_array << EleContract.find(contracts_sorted[i].ele_contract_id)
    rescue
      return_array
    end
    return_array
  end
end
