# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FullSimulation, type: :model do
  before(:each) do
    @full_simulation = create(:full_simulation)
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(@full_simulation).to be_a(FullSimulation)
      expect(@full_simulation).to be_valid
    end

    describe '#total_cost_saved' do
      it 'should not be negative' do
        expect(build(:full_simulation, total_cost_saved: -1.00)).not_to be_valid
      end

      it 'can be 0' do
        expect(build(:full_simulation, total_cost_saved: 0.00)).to be_valid
      end

      it 'should be positive' do
        expect(build(:full_simulation, total_cost_saved: 12.3)).to be_valid
      end
    end
  end

  context 'associations' do
    describe 'gas_simulation' do
      it 'has one associated gas_simulation' do
        expect(@full_simulation).to have_one(:gas_simulation)
      end
    end

    describe 'user' do
      it 'belongs to one user' do
        expect(@full_simulation).to belong_to(:user)
      end
    end
  end

  context 'public instance methods' do
    describe '#only_one_gas_simulation' do
      it 'should return a boolean' do
        expect(@full_simulation.only_one_gas_simulation).to be_in([true, false])
      end
    end
  end
end
