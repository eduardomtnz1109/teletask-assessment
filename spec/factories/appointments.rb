# spec/factories/appointments.rb

FactoryBot.define do
  factory :appointment do
    start_time { Time.now + 1.day }
    end_time { Time.now + 1.day + 1.hour }
    status { 'pending' }
    association :doctor, factory: :user
    association :patient, factory: :user
  end
end
