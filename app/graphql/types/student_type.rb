# frozen_string_literal: true

module Types
  class StudentParamsType < Types::BaseInputObject
    description 'Attributes for creating or updating a student'
    argument :email, String, 'student email address', required: false
    argument :first_name, String, 'student first name', required: false
    argument :last_name, String, 'student last name', required: false
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
