class Api::QuestionsController < ApplicationController
  def create
    results = CreateQuestion.call(question_params)
    render json: params
    # TODO: how errors from transaction bubble up to controller
  end

  def question_params
    params.require(:question).permit(:rich_text, :tags, :question_type, :question_options)
  end 

  # sample params
  # { "question"=>
  #   {
  #     "rich_text"=>
  #       "{      \n        \"object\": \"block\",\n        \"type\": \"paragraph\",\n        \"nodes\": [\n          {\n            \"object\": \"text\",\n            \"text\": \"A line of text in a paragraph.\"\n          }\n        ]\n}", 
  #     "question_type"=>"mc"
  #     "tags"=>"science, art",
  #   }
  # }
end
