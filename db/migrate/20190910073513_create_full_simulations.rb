# frozen_string_literal: true

class CreateFullSimulations < ActiveRecord::Migration[5.2]
  def change
    create_table :full_simulations do |t|
      t.float :total_cost_saved
      t.boolean :validated, default: false
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
