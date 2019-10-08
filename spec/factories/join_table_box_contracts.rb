FactoryBot.define do
  factory :join_table_box_contract do
    savings { 1.5 }
    box_contract { create(:box_contract)}
    box_simulation { create(:box_simulation)}
  end
end
