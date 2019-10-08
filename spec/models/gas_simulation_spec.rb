# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GasSimulation, type: :model do
  before(:each) do
    @gas_simulation = create(:gas_simulation)
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(@gas_simulation).to be_a(GasSimulation)
      expect(@gas_simulation).to be_valid
    end

    describe '#actual_price_paid' do
      it 'should have an actual paid price' do
        expect(build(:gas_empty_price_paid)).not_to be_valid
      end

      it 'should be positive' do
        expect(build(:gas_simulation, actual_price_paid: -1)).not_to be_valid
      end
    end

    describe '#gas_cost_saved' do
      it 'should have an gas_cost_saved' do
        expect(build(:gas_empty_cost_saved)).not_to be_valid
      end

      it 'can be 0' do
        expect(build(:gas_zero_cost_saved)).to be_valid
      end

      it 'should be positive' do
        expect(build(:gas_simulation, actual_price_paid: -1)).not_to be_valid
      end
    end

    describe '#floor_space' do
      it 'can be empty' do
        expect(build(:gas_simulation, floor_space: nil)).to be_valid
      end

      it 'can not be under 9' do
        expect(build(:gas_simulation, floor_space: 8)).not_to be_valid
        expect(build(:gas_simulation, floor_space: 9)).to be_valid
      end
    end

    describe '#heat_type' do
      it 'can be blank' do
        expect(build(:gas_simulation, heat_type: nil)).to be_valid
      end
      it 'can be either Gaz or Electricite' do
        expect(build(:gas_simulation)).to be_valid
        expect(build(:gas_simulation, heat_type: 'other')).not_to be_valid
      end
    end

    describe '#water_cooking_type' do
      it 'can be blank' do
        expect(build(:gas_simulation, water_cooking_type: nil)).to be_valid
      end
      it 'can be either Gaz or Electricite' do
        expect(build(:gas_simulation)).to be_valid
        expect(build(:gas_simulation, water_cooking_type: 'other')).not_to be_valid
      end
    end

    describe '#residents_number' do
      it 'can be blank' do
        expect(build(:gas_simulation, residents_number: nil)).to be_valid
      end

      it 'should be greater than 1 ' do
        expect(build(:gas_simulation, residents_number: -1)).not_to be_valid
        expect(build(:gas_simulation, residents_number: 0)).not_to be_valid
      end
    end

    describe '#gas_use' do
      it 'should not be blank' do
        expect(build(:gas_simulation, gas_use: nil)).not_to be_valid
      end

      it 'should be greater than 0' do
        expect(build(:gas_simulation, gas_use: -1)).not_to be_valid
      end

      it 'should be an integer' do
        expect(build(:gas_simulation, gas_use: 1.02)).not_to be_valid
      end
    end
  end

  context 'associations' do
    describe 'gas_simulation' do
      it 'belongs to one full_simulation' do
        expect(@gas_simulation).to belong_to(:full_simulation)
      end
    end
  end

  context 'public methods' do
    describe '#consumption_people' do
      it 'should return 1630 if 1' do
        expect(@gas_simulation.consumption_people(1)).to eq(1630)
      end

      it 'should return 2945 if 2' do
        expect(@gas_simulation.consumption_people(2)).to eq(2945)
      end

      it 'should return 4265 if 3' do
        expect(@gas_simulation.consumption_people(3)).to eq(4265)
      end

      it 'should return 5320 if 4' do
        expect(@gas_simulation.consumption_people(4)).to eq(5320)
      end

      it 'should return 6360 if 5' do
        expect(@gas_simulation.consumption_people(5)).to eq(6360)
      end

      it 'should return 7360 if 6' do
        expect(@gas_simulation.consumption_people(6)).to eq(7360)
      end

      it 'should return 10360 if 9' do
        expect(@gas_simulation.consumption_people(9)).to eq(10_360)
      end
    end

    describe 'verify_nilness_params' do
      it 'should return false if yearly_cost is empty' do
        expect(@gas_simulation.verify_nilness_params(0, 7000, 100, 'Gaz', 'Gaz', 1)).to eq(false)
      end

      it 'should return false if yearly_consmption is empty and one of the other is empty' do
        expect(@gas_simulation.verify_nilness_params(100, 0, 0, 'Gaz', 'Gaz', 1)).to eq(false)
        expect(@gas_simulation.verify_nilness_params(100, 0, 50, '', 'Gaz', 1)).to eq(false)
        expect(@gas_simulation.verify_nilness_params(100, 0, 50, 'Gaz', '', 1)).to eq(false)
        expect(@gas_simulation.verify_nilness_params(100, 0, 50, 'Gaz', 'Gaz', 0)).to eq(false)
      end

      it 'should return true if yearly_consumption and cost are not 0' do
        expect(@gas_simulation.verify_nilness_params(100, 7000, 0, '', '', 0)).to eq(true)
        expect(@gas_simulation.verify_nilness_params(100, 7000, 50, '', '', 0)).to eq(true)
        expect(@gas_simulation.verify_nilness_params(100, 7000, 50, 'Gaz', '', 0)).to eq(true)
        expect(@gas_simulation.verify_nilness_params(100, 7000, 50, 'Gaz', 'Gaz', 0)).to eq(true)
        expect(@gas_simulation.verify_nilness_params(100, 7000, 50, 'Gaz', 'Gaz', 1)).to eq(true)
      end

      it 'should return true if yearly consumption 0 but everything else is not empty' do
        expect(@gas_simulation.verify_nilness_params(100, 0, 50, 'Gaz', 'Gaz', 1)).to eq(true)
      end
    end

    describe 'estimation' do
      it 'should return [false, -1] if yearly cost is empty' do
        expect(@gas_simulation.estimation('', '', '', '', '', '')).to eq([false, -1])
      end

      it 'should return yearly cost and yearly consumption if they exist' do
        expect(@gas_simulation.estimation('500', '5000', '', '', '', '')).to eq([500, 5000])
      end

      it 'should return yearly cost and yearly consumption calculated' do
        expect(@gas_simulation.estimation('500', '', '50', 'Gaz', 'Gaz', '1')).to eq([500, 6630])
        expect(@gas_simulation.estimation('500', '', '50', 'Electricite', 'Gaz', '1')).to eq([500, 1630])
        expect(@gas_simulation.estimation('500', '', '50', 'Gaz', 'Electricite', '1')).to eq([500, 5000])
      end
    end
  end
end
