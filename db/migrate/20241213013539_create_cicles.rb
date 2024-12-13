# frozen_string_literal: true

class CreateCicles < ActiveRecord::Migration[7.2]
  def change
    create_table(:cicles) do |t|
      t.integer(:month)
      t.integer(:year, null: false, default: 2024)

      t.timestamps
    end

    add_index(:cicles, [:month, :year], unique: true)
  end
end
