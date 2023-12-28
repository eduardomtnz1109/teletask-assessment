# spec/controllers/slots_controller_spec.rb
require 'rails_helper'

RSpec.describe SlotsController, type: :controller do
  let(:doctor) { create(:user, :doctor) }
  let(:slot) { create(:slot, doctor: doctor) }

  describe 'GET #index' do
    it 'returns a successful response' do
      sign_in(doctor) # Sign in a doctor or appropriate user
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new slot' do
      sign_in(doctor) # Sign in a doctor or appropriate user
      expect {
        post :create, params: { slot: attributes_for(:slot, doctor_id: doctor.id) }
      }.to change(Slot, :count).by(1)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a slot' do
      sign_in(doctor) # Sign in a doctor or appropriate user
      slot
      expect {
        delete :destroy, params: { id: slot.id }
      }.to change(Slot, :count).by(-1)
    end
  end
end
