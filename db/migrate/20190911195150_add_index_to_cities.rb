# frozen_string_literal: true

class AddIndexToCities < ActiveRecord::Migration[5.2]
  def change
    add_index :cities, :name
    add_index :cities, :zip_code
    add_index :cities, :insee_code
  end
end
