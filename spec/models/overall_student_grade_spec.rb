# frozen_string_literal: true

require "rails_helper"

RSpec.describe(OverallStudentGrade, type: :model) do
  describe "associations" do
    it { is_expected.to(belong_to(:student)) }
    it { is_expected.to(belong_to(:cicle)) }
  end
end
