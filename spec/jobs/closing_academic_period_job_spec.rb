# frozen_string_literal: true

require "rails_helper"

RSpec.describe(ClosingAcademicPeriodJob, type: :job) do
  describe "#perform" do
    let!(:cicle) { create(:cicle, month: (Time.now.utc - 1.month).month, year: (Time.now.utc - 1.month).year) }
    let(:student) { create(:student) }
    let(:programming) { create(:subject, calculation_type: "last_days_average") }
    let(:database) { create(:subject, calculation_type: "last_value") }

    before do
      create(:grade, student: student, subject: programming, obtained: 80, created_at: 2.days.ago)
      create(:grade, student: student, subject: programming, obtained: 90, created_at: 5.days.ago)
      create(:grade, student: student, subject: database, obtained: 75, created_at: 1.day.ago)
    end

    context "when the cycle is absent" do
      it "skip job" do
        Cicle.destroy_all

        expect { described_class.new.perform }.not_to(change(StudentSubjectCicle, :count))
      end
    end

    context "when the cycle is present" do
      it "Increases the StudentSubjectCicle count by the number of subjects and students covered" do
        expect { described_class.new.perform }.to(change(StudentSubjectCicle, :count).by(2))
      end

      it "calculates the average of subjects with calculation_type equal to last_days_average" do
        described_class.new.perform

        student_programming_cicle = StudentSubjectCicle.find_by(student: student, subject: programming, cicle: cicle)

        expect(student_programming_cicle.obtained).to(eq(85.0))
      end

      it "calculates the average of subjects with calculation_type equal to last_value" do
        described_class.new.perform

        student_database_cicle = StudentSubjectCicle.find_by(student: student, subject: database, cicle: cicle)

        expect(student_database_cicle.obtained).to(eq(75.0))
      end

      it "Increases the OverallStudentGrade count by the number of students covered" do
        expect { described_class.new.perform }.to(change(OverallStudentGrade, :count).by(1))
      end

      it "calculates the average of the student subject grades" do
        described_class.new.perform

        overall_student_grade = OverallStudentGrade.find_by(student: student, cicle: cicle)

        expect(overall_student_grade.obtained).to(eq(80.0))
      end
    end
  end
end
