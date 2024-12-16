# frozen_string_literal: true

FactoryBot.define do
  factory :cicle do
    month { Random.rand(1..12) }
    year { Random.rand(2024..2100) }
  end
end
