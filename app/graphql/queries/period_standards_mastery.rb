# frozen_string_literal: true

module Queries
  class PeriodStandardsMastery < BaseQuery
    graphql_name 'Standards mastery data for a given period'
    description 'Given a period, return the mastery results for that period'

    argument :period_id, ID, required: true

    type [Types::PeriodStandardsMasteryType], null: false

    def resolve(period_id:)
      # teacher_signed_in?
      period = Period.find(period_id)
      standards = period.standards_chart.standards.includes(:responses)
      results = []
      standards.each do |standard|
        result = {
          standard: {
            id: standard.id,
            title: standard.title
          },
          student_performance: {}
        }
        period.students.each do |student|
          responses = standard.responses.includes(
            :question, question: :questions_standards
          ).where(student_id: student.id)
          num_responses = responses.count
          next unless num_responses.positive?

          num_correct = 0
          responses.each do |response|
            if !response.mc_correct.nil?
              # question is multiple choice
              num_correct += 1 if response.mc_correct
            elsif !response.self_grade.nil?
              # question is free response
              num_correct += 1 if response.self_grade >= 4
            end
          end
          result[:student_performance][student.id] = (
            num_correct.to_f / num_responses * 100
          ).round
        end
        result[:student_performance] = result[:student_performance].to_json
        results << result
      end
      results
    end
  end
end
