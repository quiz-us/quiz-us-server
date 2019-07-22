class Api::QuestionsController < ApplicationController
  def create
    results = CreateQuestion.call(question_params)
    render json: params

    # TODO: how errors from transaction bubble up to controller

    # sample params
    # {
    #   standard: '8.5a',
    #   questionType: 'Multiple Choice',
    #   tags: ['Periodic Table', 'Metals'],
    #   question: {`SlateJS object`}
    #   answers: [`SlateJS Object` `SlateJS Object`, `SlateJS Object`, `SlateJS Object`]
    # }
  end

  def question_params
    params.require(:question).permit(:question_node, :tags, :question_type, :question_options)
  end 

  # sample params
  # { "question"=>
  #   {
  #     "question_node"=>
  #       "{      \n        \"object\": \"block\",\n        \"type\": \"paragraph\",\n        \"nodes\": [\n          {\n            \"object\": \"text\",\n            \"text\": \"A line of text in a paragraph.\"\n          }\n        ]\n}", 
  #     "question_type"=>"mc"
  #     "tags"=>"science, art",
  #   }
  # }
end
