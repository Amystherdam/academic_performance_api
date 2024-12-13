# frozen_string_literal: true

class Cicle < ApplicationRecord
  has_many :student_subject_cicle, dependent: :destroy
  has_many :students, through: :student_subject_cicle
  has_many :subjects, through: :student_subject_cicle
end
