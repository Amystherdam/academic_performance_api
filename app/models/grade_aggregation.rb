# frozen_string_literal: true

class GradeAggregation
  attr_reader :student, :subject, :cicle

  def initialize(student:, cicle:, subject: nil)
    @student = student
    @subject = subject
    @cicle = cicle
  end

  def calculate_final_subject_grades_by_student
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

  def calculate_student_final_grade
    student_subject_cicle_grades = StudentSubjectCicle.where(student_id: student.id, cicle_id: cicle.id)
    student_subject_cicle_grades_average = (student_subject_cicle_grades.pluck(:obtained).sum / student_subject_cicle_grades.count).round(2)

    overall_student_grade = OverallStudentGrade.find_or_create_by(student_id: student.id, cicle_id: cicle.id)
    overall_student_grade.obtained = student_subject_cicle_grades_average
    overall_student_grade.save!
  end
end
