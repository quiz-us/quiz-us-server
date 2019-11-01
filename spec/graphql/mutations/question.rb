require 'rails_helper'

describe 'question mutations' do
  # let (:mc_question) { create(:mc_question, wrong_count: 10) } 
  let (:mc_question) { create(:mc_question) } 
  before(:each) do
    # # stub out current_course to get around authentication:
    # allow_any_instance_of(Mutations::Period::EditPeriod).to receive(
    #   :current_course
    # ).and_return(course)

    # allow_any_instance_of(Mutations::Period::DeletePeriod).to receive(
    #   :current_course
    # ).and_return(course)
  end

  describe 'update' do 
    it 'updates the ' do
      mutation_string = <<-GRAPHQL
        mutation updateQuestion(
           $id: ID!
          #  $questionType: String
          #  $standardId: ID
           $tags: [String!]
          #  $richText: String
           $questionPlaintext: String
           $questionOptions: [String!]
         ) {
           updateQuestion(
             id: $id
            #  questionType: $questionType
            #  standardId: $standardId
             tags: $tags
            #  richText: $richText
             questionPlaintext: $questionPlaintext
             questionOptions: $questionOptions
           ) {
             id
             questionType
             standards {
               id
               title
             }
             questionText
             richText
             tags {
               id
               name
             }
             questionOptions {
               id
               correct
               optionText
               richText
             }
           }
         }
      GRAPHQL
      new_question_text = Faker::Lorem.sentence
      new_question = QuizUsServerSchema.execute(
        mutation_string, variables: {
          id: mc_question.id,
          questionPlaintext: new_question_text
        }
      ).to_h['data']['updateQuestion']

      expect(new_question['questionText']).to eq(new_question_text)
    end 
  end 
end 