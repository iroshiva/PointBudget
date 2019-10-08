# frozen_string_literal: true

class JoinTableGasSimulationContract < ApplicationRecord
  belongs_to :gas_simulation
  belongs_to :gas_contract
end
