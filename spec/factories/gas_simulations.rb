# frozen_string_literal: true

FactoryBot.define do
  factory :gas_simulation do
    actual_price_paid { 1.5 }
    gas_cost_saved { 1.5 }
    floor_space { 10 }
    heat_type { %w(Gaz Electricite).sample }
    water_cooking_type { %w(Gaz Electricite).sample }
    residents_number { 1 }
    gas_use { 1000 }
    full_simulation { create(:full_simulation) }
    factory :gas_empty_price_paid do
      actual_price_paid {}
    end
    factory :gas_empty_cost_saved do
      gas_cost_saved {}
    end
    factory :gas_zero_cost_saved do
      gas_cost_saved { 0 }
    end
  end
end
