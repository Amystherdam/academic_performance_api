# frozen_string_literal: true

require "sidekiq"

class ClosingAcademicPeriodJob
  include Sidekiq::Job

  def perform
    cicle = Cicle.find_by(month: Time.now.utc.month, year: Time.now.utc.year)

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
end
