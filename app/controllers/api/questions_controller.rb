class Api::QuestionsController < ApplicationController
  def create
    results = CreateQuestion.call(question_params)
    render json: params

    # TODO: how errors from transaction bubble up to controller
  end

  def question_params
    params.require(:question).permit(:question, :tags, :question_type, :question_options)
  end 
end
