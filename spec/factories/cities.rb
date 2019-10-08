# frozen_string_literal: true

FactoryBot.define do
  factory :city do
    name { Faker::Address.city }
    zip_code { %w[00123 12345].sample }
    insee_code { "123456" }
    factory :city_less_zip do
      zip_code{ "123" }
    end
    factory :city_more_zip do
      zip_code{ "123" }
    end
    factory :city_empty_zip do
      zip_code{ "" }
    end
  end
end
