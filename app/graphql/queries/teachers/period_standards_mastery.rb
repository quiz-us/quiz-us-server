# frozen_string_literal: true

module Queries
  module Teachers
    class PeriodStandardsMastery < TeacherQuery
      graphql_name 'Standards mastery data for a given period'
      description 'Given a period, return the mastery results for that period'

      argument :period_id, ID, required: true

      type [Types::PeriodStandardsMasteryType], null: false

      def resolve(period_id:)
        period = Period.find(period_id)
        results = []
        standards = current_course.standards
        masteries = StandardMastery.where(
          student: period.students,
          standard: standards
        )

        m_cache = {}
        masteries.each do |m|
          m_cache["#{m.student_id}-#{m.standard_id}"] = m
        end

        standards.each do |standard|
          result = {
            standard: {
              id: standard.id,
              title: standard.title
            },
            student_performance: {}
          }

          period.students.each do |student|
            mastery = m_cache["#{student.id}-#{standard.id}"]

            if mastery
              result[:student_performance][student.id] = "#{mastery.num_correct} / #{mastery.num_attempts}"
            else
              result[:student_performance][student.id] = ''
            end
          end

          result[:student_performance] = result[:student_performance].to_json
          results << result
        end

        results
      end
    end
  end
end
