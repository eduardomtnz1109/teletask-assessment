# spec/factories/slots.rb

FactoryBot.define do
  factory :slot do
    start_time { Time.now + 1.day }
    end_time { Time.now + 1.day + 30.minutes }
    state { true }
    association :doctor, factory: :user
  end
end
