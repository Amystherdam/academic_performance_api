# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Cicle, type: :model) do
  describe "associations" do
    it { is_expected.to(have_many(:student_subject_cicle).dependent(:destroy)) }
    it { is_expected.to(have_many(:overall_student_grades).dependent(:destroy)) }
    it { is_expected.to(have_many(:students).through(:student_subject_cicle)) }
    it { is_expected.to(have_many(:subjects).through(:student_subject_cicle)) }
  end

  describe "enums" do
    def expected_month_enum
      {
        "january" => 1,
        "february" => 2,
        "march" => 3,
        "april" => 4,
        "may" => 5,
        "june" => 6,
        "july" => 7,
        "august" => 8,
        "september" => 9,
        "october" => 10,
        "november" => 11,
        "december" => 12,
      }
    end

    it "confirm month enum structure" do
      expect(described_class.months).to(eq(expected_month_enum))
    end
  end

  describe "dependents" do
    let(:cicle) { create(:cicle) }

    before do
      create(:student_subject_cicle, cicle:)
      create(:overall_student_grade, cicle:)
    end

    it "destroys the associated student_subject_cicle" do
      expect { cicle.destroy }.to(change(StudentSubjectCicle, :count).by(-1))
    end

    it "destroys the associated overall_student_grade" do
      expect { cicle.destroy }.to(change(OverallStudentGrade, :count).by(-1))
    end
  end
end
