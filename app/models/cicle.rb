# frozen_string_literal: true

class Cicle < ApplicationRecord
  has_many :student_subject_cicle, dependent: :destroy
  has_many :students, through: :student_subject_cicle
  has_many :subjects, through: :student_subject_cicle

  enum :month, { january: 0, february: 1, march: 2, april: 3, may: 4, june: 5, july: 6, august: 7, september: 8, october: 9, november: 10, december: 11 }
end
