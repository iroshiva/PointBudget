# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET show' do
    login_user
    it 'should have a current_user' do
      expect(subject.current_user).to_not eq(nil)
    end

    it 'renders the show template' do
      get :show, params: { id: subject.current_user.id }
      expect(response).to have_http_status(:success)
    end

    it 'redirect to his root page if try to see another user' do
      create(:user)
      get :show, params: { id: (subject.current_user.id.to_i + 1) }
      expect(response).to redirect_to("/users/#{subject.current_user.id}/full_simulations/new")
    end
  end

  describe 'anonymous user' do
    it 'should be redirected to signin for show' do
      user = create(:user)
      get :show, params: { id: user.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'should be redirected to signin for edit' do
      user = create(:user)
      get :edit, params: { id: user.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET edit' do
    login_user
    it 'assigns @users' do
      get :edit, params: { id: subject.current_user.id }
      expect(assigns(:user)).to eq(subject.current_user)
    end

    it 'renders the edit template' do
      get :edit, params: { id: subject.current_user.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'PUT update' do
    login_user

    context 'with valid attributes' do
      before :each do
        @first_name = Faker::Name.first_name
        @last_name = Faker::Name.last_name
      end
      it 'located the requested @user' do
        put :update, params: { id: subject.current_user,
                               user: { first_name: @first_name,
                                       last_name: @last_name,
                                       city_id: '' } }
        expect(assigns(:user)).to eq(subject.current_user)
      end

      it "changes @user's attributes" do
        put :update, params: { id: subject.current_user,
                               user: { first_name: @first_name,
                                       last_name: @last_name,
                                       city_id: '' } }
        subject.current_user.reload
        expect(subject.current_user.first_name).to eq(@first_name)
        expect(subject.current_user.last_name).to eq(@last_name)
      end

      it 'redirects to the updated contact' do
        put :update, params: { id: subject.current_user,
                               user: { first_name: @first_name,
                                       last_name: @last_name,
                                       city_id: '',
                                       phone_number: '0505060607' } }
        expect(response).to redirect_to subject.current_user
      end
    end

    context 'with invalid attributes' do
      it 'locates the requested @user' do
        put :update, params: { id: subject.current_user,
                               user: { phone_number: '0505',
                                       city_id: '' } }
        expect(assigns(:user)).to eq(subject.current_user)
      end

      it "does not change subject.current_user's attributes" do
        put :update, params: { id: subject.current_user,
                               user: { phone_number: '0505',
                                       city_id: '' } }
        subject.current_user.reload
        expect(subject.current_user.phone_number).not_to eq('0505')
      end

      it 're-renders the edit method' do
        put :update, params: { id: subject.current_user,
                               user: { phone_number: '0505',
                                       city_id: '' } }
        expect(response).to render_template :edit
      end
    end
  end
end
