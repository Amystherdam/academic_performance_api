# frozen_string_literal: true

class Subject < ApplicationRecord
  has_many :student_subject_cicle, dependent: :destroy
  has_many :cicles, through: :student_subject_cicle
  has_many :students, through: :student_subject_cicle

  enum :calculation_type, { last_days_average: 0, last_value: 1 }

  validates :days_interval, numericality: { greater_than_or_equal_to: 90, less_than_or_equal_to: 365, only_integer: true }, allow_nil: true
end
