class BoxContract < ApplicationRecord
  has_many :join_table_box_contracts, dependent: :destroy
end
