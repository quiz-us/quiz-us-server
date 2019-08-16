# frozen_string_literal: true

require 'csv'

# Texas 8th GRADE SCIENCE:

grade_8_teks = StandardsChart.create!(title: 'TEKS - 8th Grade Science')

categories_map = {}

CSV.foreach('./db/seeds/categories.csv') do |row|
  key = row[0]
  category_title = row[1]
  category_description = row[2]

  category = grade_8_teks.standards_categories.create!(
    title: category_title,
    description: category_description
  )

  categories_map[key] = category
end

CSV.foreach('./db/seeds/standards.csv') do |row|
  title = row[0]
  description = row[1]
  meta = row[2]
  key = row[3]

  categories_map[key].standards.create!(
    title: title,
    description: description,
    meta: meta
  )
end

question1 = Question.create!(
  question_text: 'What are the physical characteristics of metals?',
  question_type: 'free_response',
  question_node: '{
    "object": "value",
    "document": {
      "object": "document",
      "data": {},
      "nodes":[
        {
          "object": "block",
          "type": "line",
          "data": {},
          "nodes": [
            {
              "object": "text",
              "text": "What are the physical characteristics of metals?",
              "marks": []
            }
          ]
        }
      ]
    }
  }'
)

question1.question_options.create!(
  option_text: 'lustrous, good conductor, malleable, ductile',
  option_node: '{
    "value":{
      "object": "value",
      "document":{
        "object": "document",
        "data": {},
        "nodes":[
          {
            "object": "block",
            "type": "line",
            "data": {},
            "nodes":[
              {
                "object": "text",
                "text": "lustrous, good conductor, malleable, ductile",
                "marks": []
              }
            ]
          }
        ]
      }
    }
  }',
  correct: true
)

metal_tag = Tag.create!(name: 'metal')

Tagging.create!(tag: metal_tag, question: question1)

################################################################################
# CALIFORNIA CHEMISTRY:

standards_chart1 = StandardsChart.create!(title: 'Cali Chemistry')

standards_category1 = standards_chart1.standards_categories.create!(
  title: 'Periodic Table',
  description: 'Students will be able to understand the periodic table'
)

standard1 = standards_category1.standards.create!(
  title: 'standard 1',
  description: 'Standard 1 is awesome'
)

q1 = Question.create(
  question_type: 'multiple-choice',
  question_text: 'What are you doing?',
  question_node: '{
        "object": "block",
        "type": "paragraph",
        "nodes": [
          {
            "object": "text",
            "text": "A line of text in a paragraph."
          }
        ]
      }'
)

QuestionsStandard.create!(
  question_id: q1.id,
  standard_id: standard1.id
)

tag1 = Tag.create!(
  name: 'Chemistry'
)

tagging1 = Tagging.create!(
  question_id: q1.id,
  tag_id: tag1.id
)

chris = Teacher.create!(
  email: 'chris.d.hua@gmail.com',
  password: 'chrischrischris'
)

Course.create!(
  name: 'Texas 8th Grade Science',
  teacher: chris,
  standards_chart: grade_8_teks
)
