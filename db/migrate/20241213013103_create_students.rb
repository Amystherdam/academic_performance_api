# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[7.2]
  def change
    create_table(:students) do |t|
      t.string(:name, null: false, default: "")

      t.timestamps
    end
  end
end
