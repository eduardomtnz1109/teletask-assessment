# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    phone_number { "+#{Faker::Number.unique.number(digits: 10)}" }
    role { 'doctor' }
    phone_verified { true }
    password { 'password123' }
  end

  factory :doctor, parent: :user do
    role { 'doctor' }
  end

  factory :patient, parent: :user do
    role { 'patient' }
  end

  trait :phone_unverified do
    phone_verified { false }
  end
end
