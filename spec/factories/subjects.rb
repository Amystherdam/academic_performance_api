# frozen_string_literal: true

FactoryBot.define do
  factory :subject do
    name { Faker::Educator.subject }
    calculation_type { 0 }
    days_interval { 90 }
  end
end
