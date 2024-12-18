# frozen_string_literal: true

class Grade < ApplicationRecord
  belongs_to :student
  belongs_to :subject

  validates :obtained, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  after_create :grades_progressive_aggregation

  private

  def grades_progressive_aggregation
    cicle = Cicle.find_by(month: Time.now.utc.month, year: Time.now.utc.year)

    return if cicle.nil?

    GradeAggregation.new(student:, subject:, cicle:).calculate_final_subject_grades_by_student
    GradeAggregation.new(student:, cicle:).calculate_student_final_grade
  end
end
