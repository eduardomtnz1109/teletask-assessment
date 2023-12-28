# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with a name, phone_number, and role' do
      user = User.new(
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone_number: '+1234567890',
        role: 'doctor',
        password: 'password'
      )
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a phone_number' do
      user = User.new(phone_number: nil)
      user.valid?
      expect(user.errors[:phone_number]).to include("can't be blank")
    end

    it 'is invalid without a role' do
      user = User.new(role: nil)
      user.valid?
      expect(user.errors[:role]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'has many doctor_appointments' do
      association = described_class.reflect_on_association(:doctor_appointments)
      expect(association.macro).to eq :has_many
      expect(association.options[:class_name]).to eq 'Appointment'
      expect(association.options[:foreign_key]).to eq 'doctor_id'
    end

    it 'has many patient_appointments' do
      association = described_class.reflect_on_association(:patient_appointments)
      expect(association.macro).to eq :has_many
      expect(association.options[:class_name]).to eq 'Appointment'
      expect(association.options[:foreign_key]).to eq 'patient_id'
    end

    it 'has many slots' do
      association = described_class.reflect_on_association(:slots)
      expect(association.macro).to eq :has_many
      expect(association.options[:foreign_key]).to eq 'doctor_id'
    end
  end

  describe 'methods' do
    it 'creates default slots for doctors' do
      doctor = create(:user, :doctor)
      expect { doctor.create_default_slots }.to change { Slot.count }.by(16)
    end
  end
end
