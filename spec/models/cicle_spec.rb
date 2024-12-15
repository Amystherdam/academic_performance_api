# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Cicle, type: :model) do
  describe "associations" do
    it { is_expected.to(have_many(:student_subject_cicle).dependent(:destroy)) }
    it { is_expected.to(have_many(:overall_student_grades).dependent(:destroy)) }
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

    it "defines :month correctly" do
      expect(described_class.months).to(eq(expected_month_enum))
    end
  end

  describe "dependent destroy" do
    let(:cicle) { create(:cicle) }

    before do
      create(:student_subject_cicle, cicle:)
      create(:overall_student_grade, cicle:)
    end

    it "destroys associated student_subject_cicle when cicle is destroyed" do
      expect { cicle.destroy }.to(change(StudentSubjectCicle, :count).by(-1))
    end

    it "destroys associated overall_student_grade when cicle is destroyed" do
      expect { cicle.destroy }.to(change(OverallStudentGrade, :count).by(-1))
    end
  end
end