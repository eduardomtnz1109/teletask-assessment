class User < ApplicationRecord
  attr_accessor :verification_code
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { patient: 0, doctor: 1 }

  scope :doctors, -> { where(role: 'doctor') }
  scope :patients, -> { where(role: 'patient') }

  has_many :doctor_appointments, class_name: 'Appointment', foreign_key: 'doctor_id'
  has_many :patient_appointments, class_name: 'Appointment', foreign_key: 'patient_id'
  has_many :slots, foreign_key: 'doctor_id', dependent: :destroy

  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A\+\d+\z/, message: 'must be in the format: +1234567890' }
  validates :role, presence: true

  def create_default_slots
    # Set the application's timezone to EST
    Time.use_zone('Eastern Time (US & Canada)') do
      # Get the current date and time
      current_time = Time.zone.now
      # Create the start time and end time with the specified time zone
      start_time = Time.zone.local(current_time.year, current_time.month, current_time.day, 4, 0) # Start at 9:00 AM EST
      end_time = Time.zone.local(current_time.year, current_time.month, current_time.day, 12, 0) # End at 5:00 PM EST

      # Create 16 slots with 30-minute intervals
      16.times do
        # Create and save a new Slot object with the start time and end time
        slots.create!(start_time: start_time, end_time: start_time + 30.minutes)
        # Increment the start time by 30 minutes and assign it to the start_time variable
        start_time = start_time + 30.minutes
      end
    end
  end
end
