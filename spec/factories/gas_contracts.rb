# frozen_string_literal: true

FactoryBot.define do
  factory :gas_contract do
    supplier { 'MyString' }
    offer_name { 'MyString' }
    high_kw_consumption_per_year { 1 }
    low_kw_consumption_per_year { 0 }
    subscription_base_price_month { rand(6.00..40.00) }
    kwh_price_base { rand(0.04000..0.10000) }
    factory :gas_contract_less_subscription do
      subscription_base_price_month { rand(0.00..5.00) }
    end
    factory :gas_contract_more_subscription do
      subscription_base_price_month { rand(41.00..100.00) }
    end
    factory :gas_contract_less_price_base do
      kwh_price_base { rand(0.0..0.03) }
    end
    factory :gas_contract_more_price_base do
      kwh_price_base { rand(0.11000..1.10000) }
    end
  end
end
