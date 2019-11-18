# frozen_string_literal: true

require 'csv'

# drop all existing data:
# ActiveRecord::Base.connection.tables.each do |table|
#   next if %w[schema_migrations ar_internal_metadata].include?(table)

#   table.classify.constantize.delete_all
# end

# Texas 8th GRADE SCIENCE:

# grade_8_teks = StandardsChart.create!(title: 'TEKS - 8th Grade Science')

# categories_map = {}

# CSV.foreach('./db/seeds/categories.csv') do |row|
#   key = row[0]
#   category_title = row[1]
#   category_description = row[2]

#   category = grade_8_teks.standards_categories.create!(
#     title: category_title,
#     description: category_description
#   )

#   categories_map[key] = category
# end

# CSV.foreach('./db/seeds/standards.csv') do |row|
#   title = row[0]
#   description = row[1]
#   meta = row[2]
#   key = row[3]

#   categories_map[key].standards.create!(
#     title: title,
#     description: description,
#     meta: meta
#   )
# end

# question1 = Question.create!(
#   question_text: 'What are the physical characteristics of metals?',
#   question_type: 'free_response',
#   rich_text: '{
#     "object": "value",
#     "document": {
#       "object": "document",
#       "data": {},
#       "nodes":[
#         {
#           "object": "block",
#           "type": "line",
#           "data": {},
#           "nodes": [
#             {
#               "object": "text",
#               "text": "What are the physical characteristics of metals?",
#               "marks": []
#             }
#           ]
#         }
#       ]
#     }
#   }'
# )

# QuestionsStandard.create!(
#   question: question1,
#   standard: Standard.find_by(title: '6.6A')
# )

# question1.question_options.create!(
#   option_text: 'lustrous, good conductor, malleable, ductile',
#   rich_text: '{
#     "object": "value",
#     "document":{
#       "object": "document",
#       "data": {},
#       "nodes":[
#         {
#           "object": "block",
#           "type": "line",
#           "data": {},
#           "nodes":[
#             {
#               "object": "text",
#               "text": "lustrous, good conductor, malleable, ductile",
#               "marks": []
#             }
#           ]
#         }
#       ]
#     }
#   }',
#   correct: true
# )

# metal_tag = Tag.create!(name: 'metal')

# Tagging.create!(tag: metal_tag, question: question1)

# question2 = Question.create!(
#   question_text: 'A mystery element is dull, yellow, and powdery. Which of the following best fits the description?',
#   question_type: 'multiple_choice',
#   rich_text: '{
#     "object": "value",
#     "document": {
#       "object": "document",
#       "data": {},
#       "nodes":[
#         {
#           "object": "block",
#           "type": "line",
#           "data": {},
#           "nodes": [
#             {
#               "object": "text",
#               "text": "A mystery element is dull, yellow, and powdery. Which of the following best fits the description?",
#               "marks": []
#             }
#           ]
#         }
#       ]
#     }
#   }'
# )

# QuestionsStandard.create!(
#   question: question2,
#   standard: Standard.find_by(title: '6.6A')
# )

# question2.question_options.create!(
#   option_text: 'nonmetal',
#   rich_text: '{
#     "object": "value",
#     "document":{
#       "object": "document",
#       "data": {},
#       "nodes":[
#         {
#           "object": "block",
#           "type": "line",
#           "data": {},
#           "nodes":[
#             {
#               "object": "text",
#               "text": "nonmetal",
#               "marks": []
#             }
#           ]
#         }
#       ]
#     }
#   }',
#   correct: true
# )

# question2.question_options.create!(
#   option_text: 'metal',
#   rich_text: '{
#     "object": "value",
#     "document":{
#       "object": "document",
#       "data": {},
#       "nodes":[
#         {
#           "object": "block",
#           "type": "line",
#           "data": {},
#           "nodes":[
#             {
#               "object": "text",
#               "text": "metal",
#               "marks": []
#             }
#           ]
#         }
#       ]
#     }
#   }',
#   correct: false
# )

# question2.question_options.create!(
#   option_text: 'metalloid',
#   rich_text: '{
#     "object": "value",
#     "document":{
#       "object": "document",
#       "data": {},
#       "nodes":[
#         {
#           "object": "block",
#           "type": "line",
#           "data": {},
#           "nodes":[
#             {
#               "object": "text",
#               "text": "metalloid",
#               "marks": []
#             }
#           ]
#         }
#       ]
#     }
#   }',
#   correct: false
# )

# nonmetal_tag = Tag.create!(name: 'nonmetal')
# metalloid_tag = Tag.create!(name: 'metalloid')

# Tagging.create!(tag: metal_tag, question: question2)
# Tagging.create!(tag: nonmetal_tag, question: question2)
# Tagging.create!(tag: metalloid_tag, question: question2)

################################################################################
# CALIFORNIA CHEMISTRY:

standards_chart1 = StandardsChart.create!(title: 'California Highschool Chemistry')

standards_category1 = standards_chart1.standards_categories.create!(
  title: 'Periodic Table',
  description: 'Students will be able to understand the periodic table'
)

standard1 = standards_category1.standards.create!(
  title: 'HS-PS1-1',
  description: 'Use the periodic table as a model to predict the relative properties of elements based on the patterns of electrons in the outermost energy level of atoms'
)

standard2 = standards_category1.standards.create!(
  title: 'HS-PS1-2',
  description: 'Properties of elements based on the patterns of electrons in the outermost energy level of atoms'
)

q1 = Question.create(
  question_type: 'multiple_choice',
  question_text: 'Which periodic table contains the most reactive elements?',
  rich_text: {
    object: 'value',
    document: {
      object: 'document',
      data: {},
      nodes: [{
        object: 'block',
        type: 'line',
        data: {},
        nodes: [{
          object: 'text',
          text: 'q1',
          marks: []
        }]
      }]
    }
  }.to_json
)

QuestionsStandard.create!(
  question_id: q1.id,
  standard_id: standard1.id
)

QuestionOption.create!(
  question_id: q1.id,
  option_text: 'Noble Gases',
  correct: true,
  rich_text: {
    object: 'value',
    document: {
      object: 'document',
      data: {},
      nodes: [{
        object: 'block',
        type: 'line',
        data: {},
        nodes: [{
          object: 'text',
          text: 'a1',
          marks: []
        }]
      }]
    }
  }.to_json
)

QuestionOption.create!(
  question_id: q1.id,
  option_text: 'Noble Gases',
  correct: false,
  rich_text: {
    object: 'value',
    document: {
      object: 'document',
      data: {},
      nodes: [{
        object: 'block',
        type: 'line',
        data: {},
        nodes: [{
          object: 'text',
          text: 'a2',
          marks: []
        }]
      }]
    }
  }.to_json
)

tag1 = Tag.create!(
  name: 'Common Core Chemistry'.downcase
)

tag2 = Tag.create!(
  name: 'Periodic Table'.downcase
)

Tagging.create!(
  question_id: q1.id,
  tag_id: tag1.id
)

Tagging.create!(
  question_id: q1.id,
  tag_id: tag2.id
)

cynthia = Teacher.create!(
  email: 'cyn@gmail.com',
  password: 'cyn@gmail.com'
)

Course.create!(
  name: 'SY19 S1 Chemistry P2',
  teacher: cynthia,
  standards_chart: standards_chart1
)

josh = Teacher.create!(
  email: 'joshling1919@gmail.com',
  password: 'joshjoshjosh'
)

Course.create!(
  name: 'Texas 8th Grade Science 2',
  teacher: josh,
  standards_chart: StandardsChart.find_by(title: 'TEKS - 8th Grade Science')
)
