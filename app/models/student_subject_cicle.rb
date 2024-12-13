# frozen_string_literal: true

class StudentSubjectCicle < ApplicationRecord
  self.table_name = "students_subjects_cicles"

  belongs_to :student
  belongs_to :subject
  belongs_to :cicle
end
