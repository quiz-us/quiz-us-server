# frozen_string_literal: true

module Queries
  module Students
    class TranslatedQuestion < StudentQuery
      description 'Display one question'

      argument :question_id, ID, required: true

      type Types::QuestionType, null: false

      def resolve(question_id:)
        g_translate = Translate.new('es')
        q = Question.find(question_id)
        translated = q.as_json.merge(
          translated_question_text: g_translate.translate(q.question_text)
        )
        if q.question_type == 'Multiple Choice'
          translated[:question_options] = q.question_options.map do |qo|
            qo.as_json.merge(
              translated_option_text: g_translate.translate(qo.option_text)
            )
          end
        end
        translation = Translation.find_or_create_by!(
          student: current_student,
          question: q
        )
        translation.update!(count: translation.count + 1)
        translated
      end
    end
  end
end
