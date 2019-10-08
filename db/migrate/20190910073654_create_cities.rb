# frozen_string_literal: true

class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :zip_code
      t.string :insee_code

      t.timestamps
    end
  end
end
