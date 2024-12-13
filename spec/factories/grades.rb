# frozen_string_literal: true

FactoryBot.define do
  factory :grade do
    association :student, factory: :student
    association :subject, factory: :subject
    obtained { Faker::Number.decimal(l_digits: 2) }
  end
end
