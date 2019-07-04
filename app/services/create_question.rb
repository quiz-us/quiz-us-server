# frozen_string_literal: true

# CreateQuestion processes a question and all of its associated objects (ie.
# tags and question_options), and then creates them.
class CreateQuestion
  include Callable

  attr_reader :question, :type, :tags, :question_options
  def initialize(question_params)
    @question = question_params[:question]
    @type = question_params[:type]
    @tags = question_params[:tags]
    @question_options = question_params[:question_options]
  end

  def call
    results = {}
    ActiveRecord::Base.transaction do
      results[:question] = create_question!
      results[:question_options] = create_question_options!
      results[:tags] = create_tags!
    end
    results
  end

  private

  def create_question!
    Question.create!(
      question_text: question,
      type: type
    )
  end

  def create_question_options!
    # parse through question_options and create them
  end

  def create_tags!
    # parse through tags and create them
  end
end
