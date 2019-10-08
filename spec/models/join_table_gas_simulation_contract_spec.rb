# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JoinTableGasSimulationContract, type: :model do
  before(:each) do
    @join_table_gas_simulation_contract = create(:join_table_gas_simulation_contract)
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(@join_table_gas_simulation_contract).to be_a(JoinTableGasSimulationContract)
      expect(@join_table_gas_simulation_contract).to be_valid
    end
  end

  context 'associations' do
    describe 'gas_simulation' do
      it 'belongs to one gas_simulation' do
        expect(@join_table_gas_simulation_contract).to belong_to(:gas_simulation)
      end
    end

    describe 'gas_contract' do
      it 'belongs to one gas_contract' do
        expect(@join_table_gas_simulation_contract).to belong_to(:gas_contract)
      end
    end
  end
end
