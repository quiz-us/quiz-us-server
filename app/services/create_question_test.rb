# frozen_string_literal: true

# CreateQuestion processes a question and all of its associated objects (ie.
# tags and question_options), and then creates them.
class CreateQuestionTest
  include Callable

  attr_reader :question, :type, :tags, :question_options
  def initialize(params)
    # debugger
    params = params[:question]
    @question_node = JSON.parse(params[:question_node], symbolize_names: true)
    @question_type = params[:question_type]
    @tags = params[:question_tags].split(',').map(&:chomp)
    # @question_options_arr = params[:answers] #array of SlateJS Objects
  end

  def call
    results = {}
    # TODO: handle errors from this transaction
    ActiveRecord::Base.transaction do
      results[:question] = create_question!
      results[:tags] = create_tags!(results[:question])
      # results[:question_options] = create_question_options!(results[:question])
    end
    results
  end

  private

  def create_question!
    Question.create!(
      question_node: @question_node,
      # TODO: getting the question text is an naive approach. 
        # need to finalize a way to get ALL of the question text 
      # SUGGESTION: we either do this on the backend or frontend
        # if we choose backend, we need to iterate through nodes to extract each node's text
      question_text: @question_node[:nodes][0][:text],
      question_type: @question_type
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
      Tagging.create!(
        question_id: question.id,
        tag_id: tag.id)
    end
  end
end
