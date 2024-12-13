# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    name { Faker::Name.name }
  end
end
