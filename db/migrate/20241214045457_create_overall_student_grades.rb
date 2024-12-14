# frozen_string_literal: true

class CreateOverallStudentGrades < ActiveRecord::Migration[7.2]
  def change
    create_table(:overall_student_grades) do |t|
      t.references(:student, null: false, foreign_key: true)
      t.references(:cicle, null: false, foreign_key: true)
      t.float(:obtained)

      t.timestamps
    end

    add_index(:overall_student_grades, [:student_id, :cicle_id], unique: true)
  end
end
