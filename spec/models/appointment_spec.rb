# spec/models/appointment_spec.rb

require 'rails_helper'

RSpec.describe Appointment, type: :model do
  describe 'validations' do
    it 'is valid with a start_time, end_time, status, doctor_id, and patient_id' do
      appointment = build(:appointment)
      expect(appointment).to be_valid
    end

    it 'is invalid without a start_time' do
      appointment = build(:appointment, start_time: nil)
      appointment.valid?
      expect(appointment.errors[:start_time]).to include("can't be blank")
    end

    it 'is invalid without an end_time' do
      appointment = build(:appointment, end_time: nil)
      appointment.valid?
      expect(appointment.errors[:end_time]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs to a doctor' do
      association = described_class.reflect_on_association(:doctor)
      expect(association.macro).to eq :belongs_to
      expect(association.options[:class_name]).to eq 'User'
    end

    it 'belongs to a patient' do
      association = described_class.reflect_on_association(:patient)
      expect(association.macro).to eq :belongs_to
      expect(association.options[:class_name]).to eq 'User'
    end
  end
end
