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
  validates :floor_space,
            allow_blank: true,
            numericality: { greater_than_or_equal_to: 9 }
  validates :heat_type,
            allow_blank: true,
            format: { with: /\A(Gaz|Electricite|Autre|Non)\Z/ }
  validates :water_type,
            allow_blank: true,
            format: { with: /\A(Gaz|Electricite|Autre)\Z/ }
  validates :cooking_type,
            allow_blank: true,
            format: { with: /\A(Gaz|Electricite|Autre)\Z/ }
  validates :isolation_type,
            allow_blank: true,
            format: { with: /\A(Peu performante|Performante|Très performante)\Z/ }
  validates :residents_number,
            allow_blank: true,
            numericality: { greater_than_or_equal_to: 1 }
  validates :ele_use,
            presence: true,
            numericality: { greater_than_or_equal_to: 0, only_integer: true }

  # Set the user of the elec simulation
  def user
    self.full_simulation.user
  end

  # This method can estimate the consumption depending on the params you give to it
  def estimation(yearly_cost, yearly_consumption, floor_space, heat_type, water_type, cooking_type, nb_residents, isolation_type)
    yearly_cost = yearly_cost.to_f
    # given value is in string class
    yearly_consumption = yearly_consumption.to_i
    floor_space = floor_space.to_i
    # given value is in string class
    nb_residents = nb_residents.to_i
    # given value is in string class

    if verify_nilness_params(yearly_cost, yearly_consumption, floor_space, heat_type, water_type, cooking_type, nb_residents, isolation_type)
    # == if gas_simulation is completed
      first_factor = heat_type == 'Electricite' ? 1 : 0
      # if heat with electricity, value 1
      second_factor = water_type == 'Electricite' ? 1 : 0
      third_factor = cooking_type == 'Electricite' ? 1 : 0
      fourth_factor = 2000
      # add this factor for electro devises
      fifth_factor = isolation_type == 'Peu performante' ? 1.35 : isolation_type == 'Performante' ? 1.15 : 1

      yearly_consumption = floor_space * 110 * first_factor * fifth_factor + second_factor * nb_residents * 800 + third_factor * nb_residents * 200 
      # if yearly_consumption.zero?

      
      [yearly_cost, yearly_consumption.to_i]
      # puts an array
    else
      [false, -1]
    end
  end

  # This method execute the comparison between what is entered by the client and the contracts
  def comparison(yearly_cost, yearly_consumption, kVA_power)
    yearly_cost = yearly_cost.to_f
    yearly_consumption = yearly_consumption.to_i
    kVA_power = kVA_power.to_i
    # select the contracts corresponding to the kVA
    first_filter = EleContract.all.select { |contract| contract.kVA_power == kVA_power }
   
    # select the contracts with yearly_cost below user yearly_cost
    second_filter = first_filter.select{ |contract| yearly_cost > (contract.kwh_price_base * yearly_consumption + contract.subscription_base_price_month * 12)}

    max_save = 0
    all_savings = []
    second_filter.each do |contract|
      # calculate the difference of prices
      savings = yearly_cost - (contract.kwh_price_base * yearly_consumption + contract.subscription_base_price_month * 12)

      # define the highest save the user can make
      if savings > max_save
        max_save = savings
      end
      all_savings << savings
    end
    [max_save.round(2), second_filter, all_savings]
  end

  # This method create all the join table given by the filter == comparison[1] and the saving == comparison[2], associated with each
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

  # This method is part of the estimation process
  # It verifies the entries of the client and termine if all the fields are completed or not
  def verify_nilness_params(yearly_cost, yearly_consumption, floor_space, heat_type, water_type, cooking_type, nb_residents, isolation_type)
    if yearly_cost.zero? # if he forgot the yearly cost
      false
    else
      if yearly_consumption.zero? 
      # if the consumption is not entered, all the other field must be present
        if [floor_space, nb_residents].include?(0) || [heat_type, water_cooking_type, isolation_type].include?('')
          false
        else
          true
        end
      else
        true
      end
    end
  end
end
