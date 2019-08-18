# frozen_string_literal: true

# CreateQuestion processes a question and all of its associated objects (ie.
# tags and question_options), and then creates them.
class CreateQuestionService
  include Callable

  def initialize(params)
    @question_node = JSON.parse(params[:question_node], symbolize_names: true)
    @question_options = params[:question_options]
    @question_plaintext = params[:question_plaintext]
    @question_standard_id = params[:standard_id]
    @question_type = params[:question_type]
    @tags = params[:tags]
  end

  def call
    # TODO: handle errors from this transaction
    ActiveRecord::Base.transaction do
      @question = create_question!
      create_tags!
      map_question_to_standards!
      create_question_options!
      @question
    end
  end

  private

  def create_question!
    Question.create!(
      question_node: @question_node,
      question_text: @question_plaintext,
      question_type: @question_type
    )
  end

  def create_tags!
    @tags.each do |tag_name|
      tag = Tag.find_or_create_by!(name: tag_name)
      @question.taggings.create!(tag_id: tag.id)
    end
  end

  def map_question_to_standards!
    @question.questions_standards.create({
      standard_id: @question_standard_id
    })
  end

  def create_question_options!
    @question_options.each do |option|
      option_test = JSON.parse(option, symbolize_names: true)
      @question.question_options.create!(
        correct: option_test[:correct],
        option_node: option_test[:optionNode],
        option_text: option_test[:optionText]
      )
    end
  end
end
