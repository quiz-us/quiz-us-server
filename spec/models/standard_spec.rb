# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Standard, type: :model do
  it { should belong_to(:standards_category) }
end
