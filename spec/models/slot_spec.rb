# spec/models/slot_spec.rb

require 'rails_helper'

RSpec.describe Slot, type: :model do
  describe 'validations' do
    it 'is valid with a start_time, end_time, and state' do
      slot = build(:slot)
      expect(slot).to be_valid
    end

    it 'is invalid without a start_time' do
      slot = build(:slot, start_time: nil)
      slot.valid?
      expect(slot.errors[:start_time]).to include("can't be blank")
    end

    it 'is invalid without an end_time' do
      slot = build(:slot, end_time: nil)
      slot.valid?
      expect(slot.errors[:end_time]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs to a doctor' do
      association = described_class.reflect_on_association(:doctor)
      expect(association.macro).to eq :belongs_to
      expect(association.options[:class_name]).to eq 'User'
    end
  end
end
