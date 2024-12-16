# frozen_string_literal: true

require "rails_helper"

RSpec.describe(GradesController, type: :controller) do
  describe "POST #create" do
    let(:student) { create(:student) }
    let(:programming) { create(:subject) }

    context "with valid params" do
      let(:valid_attributes) do
        {
          grade: {
            student_id: student.id,
            subject_id: programming.id,
            obtained: 85,
          },
        }
      end

      it "create a new grade" do
        expect { post(:create, params: valid_attributes) }.to(change(Grade, :count).by(1))
      end

      it "returns created grade" do
        post :create, params: valid_attributes

        expect(response.parsed_body).to(include("student_id" => student.id, "subject_id" => programming.id, "obtained" => 85))
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) do
        {
          grade: {
            student_id: nil,
            subject_id: programming.id,
            obtained: nil,
          },
        }
      end

      it "not create a new grade" do
        expect { post(:create, params: invalid_attributes) }.not_to(change(Grade, :count))
      end

      it "returns errors" do
        post :create, params: invalid_attributes

        json_response = response.parsed_body
        expect(json_response).to(include("student" => ["must exist"], "obtained" => ["is not a number"]))
      end
    end
  end
end
