# frozen_string_literal: true

# CreateQuestion processes a question and all of its associated objects (ie.
# tags and question_options), and then creates them.
class CreateQuestion
  include Callable

  attr_reader :question, :type, :tags, :question_options
  def initialize(question_params)
    @question = question_params[:question]
    @question_type = question_params[:question_type]
    @tags = question_params[:tags].split(',').map(&:chomp)
    @question_options_arr = JSON.parse(question_params[:question_options])
  end

  def call
    results = {}
    # TODO: handle errors from this transaction
    ActiveRecord::Base.transaction do
      results[:question] = create_question!
      results[:tags] = create_tags!(results[:question])
      results[:question_options] = create_question_options!(results[:question])
    end
    results
  end

  private

  def create_question!
    Question.create!(
      question_text: @question,
      question_type: @question_type
    )
  end

  def create_question_options!(question)
    @question_options_arr.each do |_, option|
      # debugger
      
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
