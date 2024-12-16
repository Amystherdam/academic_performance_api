# frozen_string_literal: true

FactoryBot.define do
  factory :cicle do
    month { (Time.now.utc - 1.month).month }
    year { (Time.now.utc - 1.month).year }
  end
end
