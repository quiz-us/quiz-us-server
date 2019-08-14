# frozen_string_literal: true

# CreateQuestion processes a question and all of its associated objects (ie.
# tags and question_options), and then creates them.
class CreateQuestionService
  include Callable

  def initialize(params)
    params = params[:question]
    @question_type = params[:question_type]
    @question_standard_id = params[:standard_id]
    @question_node = JSON.parse(params[:question_node], symbolize_names: true)
    @tags = params[:tags]
    @question_plaintext = params[:question_plaintext]
    # @question_options_arr = params[:answers] #array of SlateJS Objects
  end

  def call
    results = {}
    # TODO: handle errors from this transaction
    ActiveRecord::Base.transaction do
      results[:question] = create_question!
      results[:tags] = create_tags!(results[:question])
      results[:standard_id] = map_question_to_standards!(results[:question])
      # results[:question_options] = create_question_options!(results[:question])
    end
    results
  end

  private

  def map_question_to_standards!(question)
    QuestionsStandard.create({
      question_id: question.id,
      standard_id: @question_standard_id
    })
  end

  def create_question!
    Question.create!(
      question_node: @question_node,
      # TODO: getting the question text is an naive approach. 
        # need to finalize a way to get ALL of the question text 
      # SUGGESTION: we either do this on the backend or frontend
        # if we choose backend, we need to iterate through nodes to extract each node's text
      question_text: @question_node[:nodes][0][:text],
      question_type: @question_type,
      question_text: @question_plaintext
    )
  end

  def create_question_options!(question)
    @question_options_arr.each do |_, option|      
      QuestionOption.create!(
        question_id: question.id,
        option_text: option["text"],
        correct: option["correct"]
      )
    end
  end

  def create_tags!(question)
    @tags.each do |tag_name|
      tag = Tag.find_or_create_by!(name: tag_name)
      Tagging.create!(question_id: question.id, tag_id: tag.id)
    end
  end
end
