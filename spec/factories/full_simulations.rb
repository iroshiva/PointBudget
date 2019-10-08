# frozen_string_literal: true

FactoryBot.define do
  factory :full_simulation do
    total_cost_saved { 1.56 }
    user { create(:user) }
    validated { false }
  end
end
