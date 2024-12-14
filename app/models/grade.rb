# frozen_string_literal: true

class Grade < ApplicationRecord
  belongs_to :student
  belongs_to :subject

  validates :obtained, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
