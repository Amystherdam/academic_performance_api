# frozen_string_literal: true

class Grade < ApplicationRecord
  belongs_to :student
  belongs_to :subject
end
