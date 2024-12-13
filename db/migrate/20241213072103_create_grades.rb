# frozen_string_literal: true

class CreateGrades < ActiveRecord::Migration[7.2]
  def change
    create_table(:grades) do |t|
      t.references(:student, null: false, foreign_key: true)
      t.references(:subject, null: false, foreign_key: true)
      t.float(:obtained, null: false, default: 0.0)

      t.timestamps
    end
  end
end
