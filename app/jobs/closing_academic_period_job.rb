# frozen_string_literal: true

require "sidekiq"

class ClosingAcademicPeriodJob
  include Sidekiq::Job

  def perform
    cicle = Cicle.find_by(month: Time.now.utc.month, year: Time.now.utc.year)

    calculate_final_subject_grades_by_student(cicle)
    calculate_students_final_grade(cicle)
  end

  private

  def calculate_final_subject_grades_by_student(cicle)
    Student.find_each do |student|
      Subject.find_each do |subject|
        student_subject_cicle = StudentSubjectCicle.find_or_create_by(student_id: student.id, subject_id: subject.id, cicle_id: cicle.id)

        case subject.calculation_type
        when "last_days_average"
          last_grades = Grade.where(student_id: student.id, subject_id: subject.id).where(created_at: (Time.now.utc - subject.days_interval.days)..)
          grades_average = last_grades.pluck(:obtained).sum / last_grades.count

          student_subject_cicle.obtained = grades_average.round(2)
        when "last_value"
          last_grade = Grade.where(student_id: student.id, subject_id: subject.id).last

          student_subject_cicle.obtained = last_grade.obtained.round(2)
        end

        student_subject_cicle.save!
      end
    end
  end

  def calculate_students_final_grade(cicle)
    Student.find_each do |student|
      student_subject_cicle_grades = StudentSubjectCicle.where(student_id: student.id, cicle_id: cicle.id)
      student_subject_cicle_grades_average = (student_subject_cicle_grades.pluck(:obtained).sum / student_subject_cicle_grades.count).round(2)

      overall_student_grade = OverallStudentGrade.find_or_create_by(student_id: student.id, cicle_id: cicle.id)
      overall_student_grade.obtained = student_subject_cicle_grades_average
      overall_student_grade.save!
    end
  end
end
