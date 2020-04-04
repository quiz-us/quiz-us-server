# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetCurrentTeacher do
  let(:teacher) { create(:teacher) }
  let(:request) { {} }
  before(:each) do
    allow_any_instance_of(GetCurrentTeacher)
      .to receive(:auth_token)
      .and_return([{ 'https://quizushq.org/email' => teacher.email }])
  end

  it 'finds teacher by email' do
    expect(GetCurrentTeacher.call(request)).to eq(teacher)
  end

  context 'when teacher did not previously sign up' do
    let(:new_teacher_email) { Faker::Internet.email }
    before(:each) do
      allow_any_instance_of(GetCurrentTeacher)
        .to receive(:auth_token)
        .and_return([{ 'https://quizushq.org/email' => new_teacher_email }])
    end
    it 'creates a new teacher' do
      expect(Teacher.find_by(email: new_teacher_email)).to eq(nil)
      expect(GetCurrentTeacher.call(request)).to eq(
        Teacher.find_by(email: new_teacher_email)
      )
    end
  end
end
