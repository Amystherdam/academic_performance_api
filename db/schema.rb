# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_12_13_072103) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cicles", force: :cascade do |t|
    t.integer "month"
    t.integer "year", default: 2024, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["month", "year"], name: "index_cicles_on_month_and_year", unique: true
  end

  create_table "grades", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "subject_id", null: false
    t.float "obtained", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_grades_on_student_id"
    t.index ["subject_id"], name: "index_grades_on_subject_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students_subjects_cicles", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "subject_id", null: false
    t.bigint "cicle_id", null: false
    t.float "obtained"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cicle_id"], name: "index_students_subjects_cicles_on_cicle_id"
    t.index ["student_id", "subject_id", "cicle_id"], name: "idx_on_student_id_subject_id_cicle_id_2220535847", unique: true
    t.index ["student_id"], name: "index_students_subjects_cicles_on_student_id"
    t.index ["subject_id"], name: "index_students_subjects_cicles_on_subject_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "calculation_type", default: 0, null: false
    t.integer "days_interval"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "grades", "students"
  add_foreign_key "grades", "subjects"
  add_foreign_key "students_subjects_cicles", "cicles"
  add_foreign_key "students_subjects_cicles", "students"
  add_foreign_key "students_subjects_cicles", "subjects"
end
