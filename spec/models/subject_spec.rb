# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Subject, type: :model) do
  describe "associations" do
    it { is_expected.to(have_many(:student_subject_cicle).dependent(:destroy)) }
    it { is_expected.to(have_many(:cicles).through(:student_subject_cicle)) }
    it { is_expected.to(have_many(:students).through(:student_subject_cicle)) }
    it { is_expected.to(have_many(:grades).dependent(:destroy)) }
  end

  describe "enums" do
    it { is_expected.to(define_enum_for(:calculation_type).with_values([:last_days_average, :last_value])) }
  end

  describe "validations" do
    context "when calculation_type is nil" do
      it "does not allow calculation_type is nil" do
        subject = described_class.new(name: Faker::Educator.subject, calculation_type: nil, days_interval: 100)
        subject.save

        expect(subject.errors.first.full_message).to(eq("Calculation type can't be blank"))
      end
    end

    context "when days_interval is a integer number" do
      it "allows days_interval is a integer number between 90 and 365" do
        subject = described_class.new(name: Faker::Educator.subject, calculation_type: :last_days_average, days_interval: 100)
        subject.save

        expect(subject.errors.size).to(eq(0))
      end
    end

    context "when days_interval is not a integer number" do
      it "does not allow days_interval is a float number" do
        subject = described_class.new(name: Faker::Educator.subject, calculation_type: :last_days_average, days_interval: 90.5)
        subject.save

        expect(subject.errors.first.full_message).to(eq("Days interval must be an integer"))
      end
    end

    context "when days_interval is less than 90" do
      it "does not allow days_interval is less than 90" do
        subject = described_class.new(name: Faker::Educator.subject, calculation_type: :last_days_average, days_interval: 89)
        subject.save

        expect(subject.errors.first.full_message).to(eq("Days interval must be greater than or equal to 90"))
      end
    end

    context "when days_interval is greater than 365" do
      it "does not allow days_interval is greater than 365" do
        subject = described_class.new(name: Faker::Educator.subject, calculation_type: :last_days_average, days_interval: 366)
        subject.save

        expect(subject.errors.first.full_message).to(eq("Days interval must be less than or equal to 365"))
      end
    end

    context "when days_interval is not a number" do
      it "does not allow days_interval is a non-numeric value" do
        subject = described_class.new(name: Faker::Educator.subject, calculation_type: :last_days_average, days_interval: "not a number")
        subject.save

        expect(subject.errors.first.full_message).to(eq("Days interval is not a number"))
      end
    end

    context "when days_interval is nil or empty and calculation_type is last_days_average" do
      it "does not allow days_interval is nil if calculation type is last_days_average" do
        subject = described_class.new(name: Faker::Educator.subject, calculation_type: :last_days_average, days_interval: nil)
        subject.save

        expect(subject.errors.first.full_message).to(eq("Days interval cannot be null"))
      end

      it "does not allow days_interval is empty if calculation type is last_days_average" do
        subject = described_class.new(name: Faker::Educator.subject, calculation_type: :last_days_average, days_interval: "")
        subject.save

        expect(subject.errors.first.full_message).to(eq("Days interval cannot be null"))
      end
    end

    context "when days_interval is nil or empty and calculation_type is last_value" do
      it "allows days_interval is nil if calculation_type is last_value" do
        subject = described_class.new(name: Faker::Educator.subject, calculation_type: :last_value, days_interval: nil)
        subject.save

        expect(subject.errors.size).to(eq(0))
      end

      it "allows days_interval is empty if calculation_type is last_value" do
        subject = described_class.new(name: Faker::Educator.subject, calculation_type: :last_value, days_interval: "")
        subject.save

        expect(subject.errors.size).to(eq(0))
      end
    end
  end

  describe "dependents" do
    let(:subjekt) { create(:subject) }

    before do
      create(:student_subject_cicle, subject: subjekt)
      create(:grade, subject: subjekt)
    end

    it "destroys the associated student_subject_cicle" do
      expect { subjekt.destroy }.to(change(StudentSubjectCicle, :count).by(-1))
    end

    it "destroys the associated grade" do
      expect { subjekt.destroy }.to(change(Grade, :count).by(-1))
    end
  end
end
