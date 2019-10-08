require 'csv'

data = CSV.read('./lib/populate_bank_contract/offer_bank.csv',
                headers: true, col_sep: ',', encoding: 'ISO-8859-1')
lines = data.reject { |line| line[0].nil? }

def to_boolean(string)
  if string.match(/true/i)
    true
  else
    false
  end
end

BankContract.destroy_all
lines.each do |line|
  BankContract.create(supplier: line[0],
      group_name: line[1],
      accounting_fees: line[2].to_f,
      inactive_accounting_fees: line[3].to_f,
      cheque: to_boolean(line[4]),
      price_cheque: line[5].to_f,
      price_order_cheque: line[6].to_f,
      insurance_payment: line[7].to_f,
      sms_alert: line[8].to_f,
      international_withdraw: line[9].to_f)
end
