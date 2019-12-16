# frozen_string_literal: true

module Questions
  class SearchQuestions
    include SearchObject.module

    option(:standard_id) do |scope, value|
      unless value.empty?
        scope.joins(:questions_standards)
             .where(questions_standards: { standard_id: value })
      end
    end

    option(:key_words) do |scope, value|
      # searches questions' question_text because of the pg_search_scope set on
      # the Question model:
      scope.search_for(value) unless value.empty?
    end
  end
end
