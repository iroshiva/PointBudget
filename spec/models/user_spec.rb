# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = create(:user)
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(@user).to be_a(User)
      expect(@user).to be_valid
    end

    describe '#email' do
      it 'should not be valid without an email' do
        bad_user = build(:user_empty_email)
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:email)).to eq(true)
      end

      it 'should not be valid without a valid email' do
        bad_user = build(:user_bad_email)
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:email)).to eq(true)
      end

      it 'should not be valid if email is already taken' do
        create(:user, email: 'to@to.com')
        bad_user = build(:user, email: 'to@to.com')
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:email)).to eq(true)
      end
    end

    describe '#password' do
      it 'should not be valid without a password' do
        bad_user = build(:user_empty_password)
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:password)).to eq(true)
      end

      it 'should not be valid with a bad password' do
        bad_user = build(:user_bad_password)
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:password)).to eq(true)
      end
    end

    describe '#phone_number' do
      it 'can be blank' do
        user = build(:user_empty_phone)
        expect(user).to be_valid
      end
      it 'should be a valid french number' do
        expect(@user.phone_number).to match(/\A((\+)33|0)[1-9](\d{2}){4}\Z/)
      end
    end
  end

  context 'associations' do
    describe 'full_simulations association' do
      it 'should have many full_simulations' do
        expect(@user).to have_many(:full_simulations)
      end
    end
  end

  context 'public instance methods' do
    describe '#city?' do
      it 'should return a boolean' do
        expect(@user.city?).to be_in([true, false])
      end

      it 'should return true if has a city' do
        expect(@user.city?).to be(true)
      end

      it 'should return false if has not a city' do
        expect(build(:user_empty_city).city?).to be(false)
      end
    end
  end
end
