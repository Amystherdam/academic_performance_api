# frozen_string_literal: true

require "sidekiq"

class MonthlyCiclesCreationJob
  include Sidekiq::Job

  def perform
    Cicle.months.keys.each do |month|
      Cicle.find_or_create_by(month:, year: Time.now.utc.year)
    end
  end
end
