# frozen_string_literal: true

class Subject < ApplicationRecord
  has_many :student_subject_cicle, dependent: :destroy
  has_many :cicles, through: :student_subject_cicle
  has_many :students, through: :student_subject_cicle
  has_many :grades, dependent: :destroy

  enum :calculation_type, { last_days_average: 0, last_value: 1 }

  validates :calculation_type, presence: true
  validates :days_interval, numericality: { greater_than_or_equal_to: 90, less_than_or_equal_to: 365, only_integer: true }, allow_nil: true
  validate :presence_of_days_interval_depending_on_calculation_type

  def presence_of_days_interval_depending_on_calculation_type
    errors.add(:days_interval, "cannot be null") if days_interval.nil? && calculation_type == "last_days_average"
  end
end
