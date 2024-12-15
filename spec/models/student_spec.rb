# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Student, type: :model) do
  describe "associations" do
    it { is_expected.to(have_many(:student_subject_cicle).dependent(:destroy)) }
    it { is_expected.to(have_many(:grades).dependent(:destroy)) }
    it { is_expected.to(have_many(:cicles).through(:student_subject_cicle)) }
    it { is_expected.to(have_many(:subjects).through(:student_subject_cicle)) }
  end

  describe "dependents" do
    let(:student) { create(:student) }
    let(:cicle) { create(:cicle) }

    before do
      create(:student_subject_cicle, student:)
      create(:overall_student_grade, student:)
      create(:grade, student:)
    end

    it "destroys the associated student_subject_cicle" do
      expect { student.destroy }.to(change(StudentSubjectCicle, :count).by(-1))
    end

    it "destroys the associated overall_student_grade" do
      expect { student.destroy }.to(change(OverallStudentGrade, :count).by(-1))
    end

    it "destroys the associated grade" do
      expect { student.destroy }.to(change(Grade, :count).by(-1))
    end
  end
end
