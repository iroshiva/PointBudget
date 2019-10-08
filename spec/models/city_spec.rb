# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City, type: :model do
  before(:each) do
    @city = create(:city)
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(@city).to be_a(City)
      expect(@city).to be_valid
    end

    describe '#zip_code' do
      it 'can\'t be more than 5 numbers' do
        bad_zip = build(:city_more_zip)
        expect(bad_zip).not_to be_valid
        expect(bad_zip.errors.include?(:zip_code)).to eq(true)
      end
      it 'can\'t be less than 5 numbers' do
        bad_zip = build(:city_less_zip)
        expect(bad_zip).not_to be_valid
        expect(bad_zip.errors.include?(:zip_code)).to eq(true)
      end

      it 'can\'t be empty' do
        bad_zip = build(:city_empty_zip)
        expect(bad_zip).not_to be_valid
        expect(bad_zip.errors.include?(:zip_code)).to eq(true)
      end
    end
  end

  context 'associations' do
    describe 'user' do
      it 'should have_many users' do
        expect(@city).to have_many(:users)
      end
    end
  end
end
