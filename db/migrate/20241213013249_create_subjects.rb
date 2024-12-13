# frozen_string_literal: true

class CreateSubjects < ActiveRecord::Migration[7.2]
  def change
    create_table(:subjects) do |t|
      t.string(:name, null: false, default: "")
      t.integer(:calculation_type, null: false, default: 0)
      t.integer(:days_interval)

      t.timestamps
    end
  end
end
