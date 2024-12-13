# frozen_string_literal: true

class Subject < ApplicationRecord
  has_many :student_subject_cicle, dependent: :destroy
  has_many :cicles, through: :student_subject_cicle
  has_many :students, through: :student_subject_cicle

  enum :calculation_type, { last_days_average: 0, last_value: 1 }
end
