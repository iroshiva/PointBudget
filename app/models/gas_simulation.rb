# frozen_string_literal: true

class GasSimulation < ApplicationRecord
  belongs_to :full_simulation
  has_many :join_table_gas_simulation_contracts, dependent: :destroy
  has_many :gas_contracts, through: :join_table_gas_simulation_contracts

  validates :actual_price_paid,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
  validates :gas_cost_saved,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
  validates :floor_space,
            allow_blank: true,
            numericality: { greater_than_or_equal_to: 9 }
  validates :heat_type,
            allow_blank: true,
            format: { with: /\A(Gaz|Electricite|Autre|Non)\Z/ }
  validates :water_cooking_type,
            allow_blank: true,
            format: { with: /\A(Gaz|Electricite|Autre)\Z/ }
  validates :isolation_type,
            allow_blank: true,
            format: { with: /\A(Peu performante|Performante|Très performante)\Z/ }
  validates :residents_number,
            allow_blank: true,
            numericality: { greater_than_or_equal_to: 1 }
  validates :gas_use,
            presence: true,
            numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def print_report
    table_attributes = []
    message = "Non renseigné"
    [floor_space, heat_type, water_cooking_type, residents_number].each do |attribute|
      if attribute.blank?
        table_attributes << message
      else
        table_attributes << attribute
      end
    end
    table_attributes
  end

  # Set the user of the gas simulation
  def user
    self.full_simulation.user
  end

  # This method can estimate the consumption depending on the params you give to it
  def estimation(yearly_cost, yearly_consumption, floor_space, heat_type, water_cooking_type, nb_residents )
    yearly_cost = yearly_cost.to_f
    yearly_consumption = yearly_consumption.to_i
    floor_space = floor_space.to_i
    nb_residents = nb_residents.to_i
    if verify_nilness_params(yearly_cost, yearly_consumption, floor_space, heat_type, water_cooking_type, nb_residents)
    # == if gas_simulation is completed
      first_factor = heat_type == 'Gaz' ? 1 : 0
      second_factor = water_cooking_type == 'Gaz' ? 1 : 0
      yearly_consumption = floor_space * 100 * first_factor + consumption_people(nb_residents) * second_factor if yearly_consumption.zero?
      [yearly_cost, yearly_consumption]
    # puts an array
    else
      [false, -1]
    end
  end

  # This method execute the comparison between what is entered by the client and the contracts
  def comparison(yearly_cost, yearly_consumption)
    # select the contracts that correspond to the yearly_consumption
    first_filter = GasContract.all.select { |contract|
      yearly_consumption.between?(contract.low_kw_consumption_per_year * 1000, contract.high_kw_consumption_per_year * 1000)
    }
    second_filter = first_filter.select{ |contract|
    # select all the contracts cheaper than the user's contract regarding the first_filter
      yearly_cost > (contract.kwh_price_base * yearly_consumption + contract.subscription_base_price_month * 12)
    }
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
  def create_join_table_gas(filter, all_savings)
    filter.each_with_index do |contract, index|
      JoinTableGasSimulationContract.create(gas_simulation: self, gas_contract: contract, savings: all_savings[index])
    end
  end

  # This method can show the top best contracts depending on the number we want to show
  def sort_contracts(how_many)
    return_array = []
    contracts_sorted = join_table_gas_simulation_contracts.sort_by(&:savings).reverse
    how_many.times do |i|
      return_array << GasContract.find(contracts_sorted[i].gas_contract_id)
    rescue
      return_array
    end
    return_array
  end

  # Estimate the consumption per habitant
  def consumption_people(nb_residents)
    hash = { 1 => 1630, 2 => 2945, 3 => 4265, 4 => 5320, 5 => 6360 }
    if hash[nb_residents].nil?
    # if nb_residents higher than 5
      hash[5] + (nb_residents - 5) * 1000
    else
      hash[nb_residents]
    # put the consumption regarding the nb_residents
    end
  end

  # This method is part of the estimation process
  # It verifies the entries of the client and termine if all the fields are completed or not
  def verify_nilness_params(yearly_cost, yearly_consumption, floor_space, heat_type, water_cooking_type, nb_residents)
    if yearly_cost.zero? # if he forgot the yearly cost
      false
    else
      if yearly_consumption.zero? # if the consumption is not entered, all the other field must be present
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
