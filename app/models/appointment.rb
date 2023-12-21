class Appointment < ApplicationRecord
  belongs_to :doctor, class_name: 'User'
  belongs_to :patient, class_name: 'User'

  enum status: { pending: 'pending', approved: 'approved', declined: 'declined' }

  validates :start_time, presence: true
  validates :end_time, presence: true
end
