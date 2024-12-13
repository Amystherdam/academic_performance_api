# frozen_string_literal: true

FactoryBot.define do
  factory :student_subject_cicle do
    association :student, factory: :student
    association :cicle, factory: :cicle
    association :subject, factory: :subject
    obtained { Faker::Number.decimal(l_digits: 2) }
  end
end
