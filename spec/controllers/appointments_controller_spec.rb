# spec/controllers/appointments_controller_spec.rb
require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  let(:doctor) { create(:user, :doctor) }
  let(:patient) { create(:user, :patient) }
  let(:appointment) { create(:appointment, doctor: doctor, patient: patient) }

  describe 'GET #index' do
    it 'returns a successful response' do
      sign_in(doctor) # Sign in a doctor or appropriate user
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      sign_in(doctor) # Sign in a doctor or appropriate user
      get :show, params: { id: appointment.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new appointment' do
      sign_in(patient) # Sign in a patient or appropriate user
      expect {
        post :create, params: { appointment: attributes_for(:appointment, doctor_id: doctor.id, patient_id: patient.id) }
      }.to change(Appointment, :count).by(1)
    end
  end
end
