# frozen_string_literal: true

FactoryBot.define do
  factory :overall_student_grade do
    association :student, factory: :student
    association :cicle, factory: :cicle
    obtained { Faker::Number.decimal(l_digits: 2) }
  end
end
