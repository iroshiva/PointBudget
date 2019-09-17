# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
#
# DON'T UNCOMMENT THE CITIES SEED
# YOU CAN CHOOSE IF YOU WANT TO SEED RANDOM CITIES OR REAL CITIES
# require 'rest-client'
# City.destroy_all
# # This is update the user cities to avoid errors
# User.all.each do |user|
#   user.update(city_id: nil)
# end
# cities_url = 'https://geo.api.gouv.fr/communes'
# data = JSON.parse( RestClient.get(cities_url) )
# data.select { |city| !city['population'].nil? && city['population'] > 5000 }.each do |city|
#   if city['codesPostaux'][0].nil?
#     City.create(name: city['nom'], insee_code: city['code'], zip_code: city['code'])
#   else
#     City.create(name: city['nom'], insee_code: city['code'], zip_code: city['codesPostaux'][0])
#   end
# end

# City.destroy_all
# 20.times do
#   City.create(name: Faker::Address.city, zip_code: '12345', insee_code: "12345")
# end

# User.destroy_all
#
# puts 'City created'
# 20.times do
#   User.create(email: Faker::Internet.email,
#               password: Faker::Internet.password,
#               first_name: Faker::Name.first_name,
#               last_name: Faker::Name.last_name,
#               phone_number: %w[0606060606 +33606060606].sample,
#               city: City.all.sample)
#   print '#'
# end
# puts ''
# puts 'Users created'
# User.create(email: 'admin123@admin.com', password: 'admin123', city: City.first, is_admin: true)
# puts 'admin created'


############################### GAZ #######################################


# require 'csv'
#
# data = CSV.read('lib/populate_gas_contract/offer_gas.csv', {:headers => false, :col_sep => ',', :encoding => 'ISO-8859-1'})
# lines = data.select { |line| !line[0].nil?}
# GasContract.destroy_all
# lines.each do |line|
#   GasContract.create(supplier: line[0],
#                      offer_name: line[1],
#                      low_kw_consumption_per_year: line[2],
#                      high_kw_consumption_per_year: line[3],
#                      subscription_base_price_month: line[4],
#                      kwh_price_base: line[5]
#   )
# end
#

############################### BOX #######################################
require 'csv'

data = CSV.read('./lib/populate_box_contract/offer_box.csv',
                headers: true, col_sep: ',', encoding: 'ISO-8859-1')
lines = data.reject { |line| line[0].blank? }


BoxContract.destroy_all
lines.each do |line|
  BoxContract.create(supplier: line[0],
                     offer_name: line[1],
                     price_month: line[2].to_i,
                     commitment: line[3].to_i,
                     price_after: line[4].to_i,
                     downstream: line[6].to_i,
                     upstream: line[7].to_i,
                     tv_channel: line[8],
                     tv: ActiveModel::Type::Boolean.new.cast(line[9]),
                     call_fix_fr: ActiveModel::Type::Boolean.new.cast(line[10]),
                     call_mobile_fr: ActiveModel::Type::Boolean.new.cast(line[11]),
                     call_foreign: ActiveModel::Type::Boolean.new.cast(line[12]),
                     opening_fee: line[13].to_i,
                     termination_fee: line[14].to_i,
                     taken_termination: line[15].to_i
  )
end