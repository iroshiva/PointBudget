require 'csv'

data = CSV.read('./lib/populate_box_contract/offer_box.csv',
                headers: true, col_sep: ',', encoding: 'ISO-8859-1')
lines = data.reject { |line| line[0].blank? }


BoxContract.destroy_all
lines.each do |line|
  BoxContract.create(supplier: line[0],
                     offer_name: line[1],
                     price_month: line[2].to_f,
                     commitment: line[3].to_i,
                     price_after: line[4].to_f,
                     internet_type: line[5].to_s,
                     downstream: line[6].to_i,
                     upstream: line[7].to_i,
                     tv_channel: line[8],
                     tv: ActiveModel::Type::Boolean.new.cast(line[9]),
                     call_fix_fr: ActiveModel::Type::Boolean.new.cast(line[10]),
                     call_mobile_fr: ActiveModel::Type::Boolean.new.cast(line[11]),
                     call_foreign: ActiveModel::Type::Boolean.new.cast(line[12]),
                     opening_fee: line[13].to_f,
                     termination_fee: line[14].to_f,
                     taken_termination: line[15].to_f
                     )
end
