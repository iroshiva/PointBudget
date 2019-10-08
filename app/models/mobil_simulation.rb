class MobilSimulation < ApplicationRecord
	has_many :join_table_mobil_contracts
	has_many :mobil_contracts, through: :join_table_mobil_contracts
	belongs_to :full_simulation

	validates :actual_price_paid,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :mobil_cost_saved,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

	# Set the user of the mobil simulation
  def user
    self.full_simulation.user
  end

  # This method is used to replace the value to show if there are not provided by the client
  def print_report
    table_attributes = []
    [calls_europe, calls_international, net_international, engagement].each do |attribute|
      if attribute == true
        table_attributes << 'Oui'
      else
        table_attributes << 'Non'
      end
    end
    table_attributes
  end

  # Def comparison
  def comparison(monthly_cost, bundle_go, calls_europe, calls_international, net_international, engagement)
  	monthly_cost = monthly_cost.to_f
  	bundle_go = bundle_go.to_f
  	first_filter = MobilContract.all.select { |contract| contract.bundle_gbyte >= bundle_go}
  	second_filter = first_filter.select { |contract| contract.calls_europe == calls_europe}
  	third_filter = second_filter.select { |contract| contract.calls_international == calls_international}
  	fourth_filter = third_filter.select { |contract| contract.net_international == net_international}
    if engagement == true 
      fifth_filter = fourth_filter
    else
      fifth_filter = fourth_filter.select { |contract| contract.engagement == false}
    end

  	sixth_filter = fifth_filter.select { |contract| contract.bundle_price < monthly_cost } # filter by price
  	max_save = 0
    all_savings = []

    sixth_filter.each do |contract|
      savings = ((monthly_cost - contract.bundle_price) * 12 ).round(2) # Find the best price
      if savings > max_save
        max_save = savings # Save the best price
      end
      all_savings << savings # Save the differences in an array, it will be use after
    end

  	[max_save.round(2), sixth_filter, all_savings] # return the max save, all the better contracts and the savings for each contracts
  end

  # This method create all the join table given by the filter and the saving associated with each
  def create_join_table_mobil(filter, all_savings)
    filter.each_with_index do |contract, index|
      JoinTableMobilContract.create(mobil_simulation: self, mobil_contract: contract, savings: all_savings[index])
    end
  end

  # This method can show the top best contracts depending on the number we want to show
  def sort_contracts(how_many)
    return_array = []
    contracts_sorted = join_table_mobil_contracts.sort_by(&:savings).reverse
    how_many.times do |i|
      return_array << MobilContract.find(contracts_sorted[i].mobil_contract_id)
    rescue
      return_array
    end
    return_array
  end

end
