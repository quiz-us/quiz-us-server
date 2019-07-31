# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

standards_chart1 = StandardsChart.create!({ title: "Cali Chemistry"})

q1 = Question.create({
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
});

tag1 = Tag.create!({
  name: 'Chemistry'
})

tagging1 = Tagging.create!({
  question_id: q1.id,
  tag_id: tag1.id
})