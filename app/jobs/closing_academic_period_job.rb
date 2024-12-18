# frozen_string_literal: true

require "sidekiq"

class ClosingAcademicPeriodJob
  include Sidekiq::Job

  def perform
    cicle = Cicle.find_by(month: (Time.now.utc - 1.month).month, year: (Time.now.utc - 1.month).year)

    return if cicle.nil?

    calculate_final_subject_grades_for_students(cicle)
    calculate_students_final_grade(cicle)
  end

  private

  def calculate_final_subject_grades_for_students(cicle)
    Student.find_each do |student|
      Subject.find_each do |subject|
        GradeAggregation.new(student:, subject:, cicle:).calculate_final_subject_grades_by_student
      end
    end
  end

  def calculate_students_final_grade(cicle)
    Student.find_each do |student|
      GradeAggregation.new(student:, cicle:).calculate_student_final_grade
    end
  end
end
