# PointBudget

Notre crédo : aider les consommateurs à savoir si ce qu’ils
              payent correspond bien au juste prix.

Venez donc faire un tout [ici](https://point-budget.herokuapp.com/)



## form box

### form ==== db box_simulation

- Coût

- Q sur Adsl/fibre/4G

- optionTV oui/non

- add option multiTV oui/non  ====== ajout t.boolean "multitv", default: true

- add Internet sur PC/Smartphone/Tablette  oui/non  ====== ajout t.boolean "internet_type", default: true

- Appels Fr fixe oui/non

- Appels Fr mobil oui/non

- remove appels étranger

- add Appels Etranger fixe oui/non   ===== ajout t.boolean "call_fix_foreign", default: true

- add Appels Etranger mobile oui/non  ===== ajout t.boolean "call_mob_foreign", default: true

- add RECUP Engagement oui/non =====  ajout t.boolean "commitment", default: true

- add RECUP Préférence appel à l'étranger  =====  ajout t.string "call_for_pref"

- add RECUP Stockage cloud  =====  ajout t.boolean "cloud", default: true


### db box_contracts

- ajout t.boolean "multitv"

- remove t.boolean "call_foreign"

- add t.boolean "call_fix_foreign"

- add t.boolean "call_mob_foreign"


### Mofifs Excel

- remove column 'Etranger'

- add column call_fix_foreign

- add column call_mob_foreign

- remove 'stockage cloud'

- fusionner 'pc'/'tablette'/'smartphones' en 'internet_type'

- remove 'bienvenue'

- remove 'condition d'obtention'


### excel to csv

https://convertio.co/fr/xls-csv/

https://www.aconvert.com/document/xls-to-csv/


### Put .csv file in lib/populate_box_contract

### in lib/populate_box_contract/populate_box_contract.rb

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
                         multitv: ActiveModel::Type::Boolean.new.cast(line[10]),
                         internet_type: ActiveModel::Type::Boolean.new.cast(line[11]),
                         call_fix_fr: ActiveModel::Type::Boolean.new.cast(line[12]),
                         call_mobile_fr: ActiveModel::Type::Boolean.new.cast(line[13]),
                         call_fix_foreign: ActiveModel::Type::Boolean.new.cast(line[14]),
                         call_mob_foreign: ActiveModel::Type::Boolean.new.cast(line[15]),
                         opening_fee: line[16].to_f,
                         termination_fee: line[17].to_f,
                         taken_termination: line[18].to_f
                         )
    end


### seed 

add content lib/populate_box_contract/populate_box_contract.rb (below)