# frozen_string_literal: true

class SetUpQrCodes < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :qr_code, :string, null: false, default: '', index: true, unique: true
  end
end
