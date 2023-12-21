class Slot < ApplicationRecord
  belongs_to :doctor, class_name: 'User'

  scope :for_today, -> {
    where('start_time >= ? AND start_time < ?', Date.today.beginning_of_day, Date.tomorrow.beginning_of_day)
  }
  scope :available, -> { where(state: true) }

  validates :start_time, presence: true
  validates :end_time, presence: true
end
