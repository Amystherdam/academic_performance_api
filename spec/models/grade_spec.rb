# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Grade, type: :model) do
  describe "associations" do
    it { is_expected.to(belong_to(:student)) }
    it { is_expected.to(belong_to(:subject)) }
  end

  describe "validations" do
    let(:student) { create(:student) }
    let(:programming) { create(:subject) }

    context "when obtained is a valid number" do
      it "allows obtained is a number between 0 and 100" do
        grade = described_class.new(student:, subject: programming, obtained: 85)
        grade.save

        expect(grade.errors.size).to(eq(0))
      end
    end

    context "when obtained is less than 0" do
      it "does not allow obtained is less than 0" do
        grade = described_class.new(student:, subject: programming, obtained: -5)
        grade.save

        expect(grade.errors.first.full_message).to(eq("Obtained must be greater than or equal to 0"))
      end
    end

    context "when obtained is greater than 100" do
      it "does not allow obtained is greater than 100" do
        grade = described_class.new(student:, subject: programming, obtained: 105)
        grade.save

        expect(grade.errors.first.full_message).to(eq("Obtained must be less than or equal to 100"))
      end
    end

    context "when obtained is not a number" do
      it "does not allow obtained is a non-numeric value" do
        grade = described_class.new(student:, subject: programming, obtained: "not a number")
        grade.save

        expect(grade.errors.first.full_message).to(eq("Obtained is not a number"))
      end
    end

    context "when obtained is nil" do
      it "does not allow obtained is nil" do
        grade = described_class.new(student:, subject: programming, obtained: nil)
        grade.save

        expect(grade.errors.first.full_message).to(eq("Obtained is not a number"))
      end
    end
  end
end
