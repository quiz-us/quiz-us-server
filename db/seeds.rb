# frozen_string_literal: true

require 'csv'

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
    meta: meta,
    standards_chart: grade_8_teks
  )
end
