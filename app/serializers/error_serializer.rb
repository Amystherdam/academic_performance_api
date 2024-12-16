# frozen_string_literal: true

class ErrorSerializer
  attr_reader :errors

  def initialize(errors)
    @errors = errors
  end

  def serialize_for(status:, resource:)
    return {} if errors.nil?

    json = { errors: [] }

    case status
    when :not_found
      serialize_not_found(json, resource)
    else
      json
    end
  end

  private

  def serialize_not_found(json, resource)
    json[:errors] << { id: resource, title: "Student not found" }
    json
  end
end
