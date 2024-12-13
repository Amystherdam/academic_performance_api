# frozen_string_literal: true

class CreateStudentsSubjectsCicles < ActiveRecord::Migration[7.2]
  def change
    create_table(:students_subjects_cicles) do |t|
      t.references(:student, null: false, foreign_key: true)
      t.references(:subject, null: false, foreign_key: true)
      t.references(:cicle, null: false, foreign_key: true)
      t.float(:obtained)

      t.timestamps
    end

    add_index(:students_subjects_cicles, [:student_id, :subject_id, :cicle_id], unique: true)
  end
end
