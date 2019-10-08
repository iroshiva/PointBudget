# frozen_string_literal: true

FactoryBot.define do
  factory :join_table_gas_simulation_contract do
    gas_simulation { create(:gas_simulation) }
    gas_contract { create(:gas_contract) }
  end
end
