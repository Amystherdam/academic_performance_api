# frozen_string_literal: true

require "rails_helper"

RSpec.describe(StudentsController, type: :controller) do
  describe "GET #index" do
    let(:student) { create(:student) }
    let(:cicle) { create(:cicle, month: (Time.now.utc - 1.month).month, year: (Time.now.utc - 1.month).year) }

    before do
      create(:overall_student_grade, cicle:, student:, obtained: 90)
    end

    it "returns overall grades for the cicle" do
      get :index

      expect(response.parsed_body).to(contain_exactly(
        a_hash_including("id" => student.id, "name" => student.name, "obtained" => 90),
      ))
    end
  end

  describe "GET #parcial_grades" do
    let(:student) { create(:student) }
    let(:subjekt) { create(:subject) }

    before do
      create(:grade, student:, subject: subjekt, obtained: 90)
    end

    context "when student exist" do
      it "returns parcial grades for a specific student" do
        get :parcial_grades, params: { id: student.id }

        expect(response.parsed_body).to(contain_exactly(
          a_hash_including("student_id" => student.id, "student_name" => student.name, "subject_name" => subjekt.name, "obtained" => 90),
        ))
      end

      it "returns not found message" do
        get :parcial_grades, params: { id: 0 }

        expect(response.parsed_body["errors"].pluck("title")).to(include("Student not found"))
      end
    end
  end

  describe "GET #final_grades" do
    let(:cicle) { create(:cicle, month: (Time.now.utc - 1.month).month, year: (Time.now.utc - 1.month).year) }
    let(:student) { create(:student) }
    let(:subjekt) { create(:subject) }

    before do
      create(:student_subject_cicle, student:, subject: subjekt, cicle:, obtained: 90)
    end

    it "returns final grades for a specific student" do
      get :final_grades, params: { id: student.id }

      expect(response.parsed_body).to(contain_exactly(
        a_hash_including("student_id" => student.id, "student_name" => student.name, "subject_name" => subjekt.name, "obtained" => 90),
      ))
    end

    it "returns not found message" do
      get :parcial_grades, params: { id: 0 }

      expect(response.parsed_body["errors"].pluck("title")).to(include("Student not found"))
    end
  end

  describe "GET #bests" do
    let(:cicle) { create(:cicle, month: (Time.now.utc - 1.month).month, year: (Time.now.utc - 1.month).year) }
    let(:john) { create(:student) }
    let(:doe) { create(:student) }
    let(:mike) { create(:student) }

    before do
      create(:overall_student_grade, student: john, cicle:, obtained: 90)
      create(:overall_student_grade, student: doe, cicle:, obtained: 80)
      create(:overall_student_grade, student: mike, cicle:, obtained: 95)
    end

    it "returns the top N students with the highest grades" do
      john_response = { "student_id" => john.id, "student_name" => john.name, "obtained" => 90 }
      doe_response = { "student_id" => doe.id, "student_name" => doe.name, "obtained" => 80 }
      mike_response = { "student_id" => mike.id, "student_name" => mike.name, "obtained" => 95 }

      get :bests, params: { size: 5 }

      expect(response.parsed_body).to(contain_exactly(a_hash_including(john_response), a_hash_including(doe_response), a_hash_including(mike_response)))
    end

    it "return the best first" do
      get :bests, params: { size: 5 }

      expect(response.parsed_body.first["student_id"]).to(eq(mike.id))
    end
  end
end
