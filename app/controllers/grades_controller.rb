# frozen_string_literal: true

class GradesController < ApplicationController
  # POST /grades
  def create
    @grade = Grade.new(grade_params)

    if @grade.save
      render(json: @grade, status: :created)
    else
      render(json: @grade.errors, status: :unprocessable_entity)
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def grade_params
    params.require(:grade).permit(:student_id, :subject_id, :obtained)
  end
end
