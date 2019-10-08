# frozen_string_literal: true

require 'csv'

data = CSV.read('./lib/populate_gas_contract/offer_gas.csv',
                headers: false, col_sep: ',', encoding: 'ISO-8859-1')
lines = data.reject { |line| line[0].nil? }
GasContract.destroy_all
lines.each do |line|
  GasContract.create(supplier: line[0],
                     offer_name: line[1],
                     low_kw_consumption_per_year: line[2],
                     high_kw_consumption_per_year: line[3],
                     subscription_base_price_month: line[4],
                     kwh_price_base: line[5])
end
