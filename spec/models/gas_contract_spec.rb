# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GasContract, type: :model do
  before(:each) do
    @gas_contract = create(:gas_contract)
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(@gas_contract).to be_a(GasContract)
      expect(@gas_contract).to be_valid
    end

    describe '#subscription_base_price_month' do
      it 'should not be valid with a too high subscription_base_price_month' do
        bad_gas_contract = build(:gas_contract_more_subscription)
        expect(bad_gas_contract).not_to be_valid
        expect(bad_gas_contract.errors.include?(:subscription_base_price_month)).to eq(true)
      end
      it 'should not be valid with a too low subscription_base_price_month' do
        bad_gas_contract = build(:gas_contract_less_subscription)
        expect(bad_gas_contract).not_to be_valid
        expect(bad_gas_contract.errors.include?(:subscription_base_price_month)).to eq(true)
      end
    end
  end
end
