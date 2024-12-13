# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Student, type: :model) do
  describe "associations" do
    it { is_expected.to(have_many(:student_subject_cicle).dependent(:destroy)) }
    it { is_expected.to(have_many(:cicles).through(:student_subject_cicle)) }
    it { is_expected.to(have_many(:subjects).through(:student_subject_cicle)) }
  end

  describe "dependent destroy" do
    let(:student) { create(:student) }
    let(:cicle) { create(:cicle) }
    let(:student_subject) { create(:subject) }

    before do
      create(:student_subject_cicle, student:)
    end

    it "destroys associated student_subject_cicle when student is destroyed" do
      expect { student.destroy }.to(change(StudentSubjectCicle, :count).by(-1))
    end
  end
end