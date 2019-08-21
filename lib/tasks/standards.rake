# frozen_string_literal: true

require 'csv'
task add_grade_8_science_teks: :environment do
  p "Adding 'TEKS - 8th Grade Science' standards chart..."
  grade_8_teks = StandardsChart.create!(title: 'TEKS - 8th Grade Science')

  p "Adding 'TEKS - 8th Grade Science' standards categories..."
  categories_map = {}
  CSV.foreach(Rails.root.join('db', 'seeds', 'categories.csv')) do |row|
    key = row[0]
    category_title = row[1]
    category_description = row[2]

    category = grade_8_teks.standards_categories.create!(
      title: category_title,
      description: category_description
    )

    categories_map[key] = category
  end

  p "Adding 'TEKS - 8th Grade Science' standards..."
  CSV.foreach(Rails.root.join('db', 'seeds', 'standards.csv')) do |row|
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

  p "Adding 'TEKS - 8th Grade Science' teacher"
  chris = Teacher.create!(
    email: 'chris.d.hua@gmail.com',
    password: 'chrischrischris'
  )

  p "Adding 'TEKS - 8th Grade Science' course"
  Course.create!(
    name: 'Texas 8th Grade Science',
    teacher: chris,
    standards_chart: grade_8_teks
  )

  p 'Done adding everything!'
end
