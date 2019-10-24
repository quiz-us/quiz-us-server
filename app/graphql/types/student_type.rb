# frozen_string_literal: true

module Types
  class StudentParamsType < Types::BaseScalar
    def self.coerce_input(value, _context)
      student_params = {}
      value.each do |k,v|
        student_params[k.underscore] = v
      end

      student_params
    end
  end

  class StudentType < BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :token, String, null: false
    field :qr_code, String, null: true
  end
end
