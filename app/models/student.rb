# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :student_subject_cicle, dependent: :destroy
  has_many :cicles, through: :student_subject_cicle
  has_many :subjects, through: :student_subject_cicle
  has_many :grades, dependent: :destroy
  has_many :overall_student_grades, dependent: :destroy
end
