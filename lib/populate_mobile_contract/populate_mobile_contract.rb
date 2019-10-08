require 'csv'

data = CSV.read('./lib/populate_mobile_contract/offer_mobile.csv',
headers: true, col_sep: ',', encoding: 'ISO-8859-1')
lines = data.reject { |line| line[0].blank? }


def to_boolean(value)
  if value == "true"
    return true 
  else
    return false
  end
end

MobilContract.destroy_all
lines.each do |line|
  MobilContract.create(supplier: line[0],
      offer_name: line[1],
      ligne_service_price: line[2].to_i,
      sim_card_price: line[3].to_i,
      engagement: to_boolean(line[4]),
      add_phone: to_boolean(line[5]),
      bundle_price: line[6].to_f,
      bundle_gbyte: line[7].to_f,
      calls_france: to_boolean(line[8]),
      calls_europe: to_boolean(line[9]),
      gbyte_europe: line[10].to_f,
      calls_international: to_boolean(line[11]),
      net_international: to_boolean(line[12])
      )
end
