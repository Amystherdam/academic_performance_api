# frozen_string_literal: true

class OverallStudentGrade < ApplicationRecord
  belongs_to :student
  belongs_to :cicle
end
