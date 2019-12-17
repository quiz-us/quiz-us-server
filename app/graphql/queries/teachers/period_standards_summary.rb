# frozen_string_literal: true

module Queries
  module Teachers
    class PeriodStandardsSummary < TeacherQuery
      graphql_name 'Standards mastery summary for a given period'
      description 'Given a period, return the mastery summary for that period'

      argument :period_id, ID, required: true

      type [Types::StandardMasteryType], null: false

      def resolve(period_id:)
        period = Period.find(period_id)

        standards = period.standards
        masteries = StandardMastery.where(
          student: period.students,
          standard: standards
        )

        m_cache = {}
        masteries.each do |m|
          if m_cache[m.standard_id]
            m_cache[m.standard_id] << m
          else
            m_cache[m.standard_id] = [m]
          end
        end

        standards.map do |standard|
          result = {
            standard: standard,
            num_attempts: m_cache[standard.id]&.sum(&:num_attempts) || 0,
            num_correct: m_cache[standard.id]&.sum(&:num_correct) || 0
          }
          if result[:num_attempts].zero?
            result[:percent_correct] = 0
          else
            result[:percent_correct] = (result[:num_correct].to_f / result[:num_attempts] * 100).round
          end
          result
        end
      end
    end
  end
end
