# frozen_string_literal: true

class Cicle < ApplicationRecord
  has_many :student_subject_cicle, dependent: :destroy
  has_many :students, through: :student_subject_cicle
  has_many :subjects, through: :student_subject_cicle

  enum :month, { january: 1, february: 2, march: 3, april: 4, may: 5, june: 6, july: 7, august: 8, september: 9, october: 10, november: 11, december: 12 }
end
