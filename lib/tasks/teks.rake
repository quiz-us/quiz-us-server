# frozen_string_literal: true

namespace :teks do
  task fourth_grade_math: :environment do
    fourth_grade_math = StandardsChart.create!(
      title: 'TEKS - 4th Grade Math'
    )

    numerical_rep = StandardsCategory.create!(
      title: 'Numerical Representations and Relationships',
      description: 'Numerical Representations and Relationships',
      standards_chart: fourth_grade_math
    )

    Standard.create!(
      description: 'represent the value of the digit in whole numbers through 1,000,000,000 and decimals to the hundredths using expanded notation and numerals',
      standards_category: numerical_rep,
      title: '4.2(B)',
      meta: 'RS'
    )

    computations = StandardsCategory.create!(
      title: 'Computations and Algebraic Relationships',
      description: 'Computations and Algebraic Relationships',
      standards_chart: fourth_grade_math
    )

    Standard.create!(
      description: 'represent and solve addition and subtraction of fractions with equal denominators using objects and pictorial models that build to the number line and properties of operations',
      standards_category: computations,
      title: '4.3(E)',
      meta: 'RS'
    )

    geometry = StandardsCategory.create!(
      title: 'Geometry and Measurement',
      description: 'Geometry and Measurement',
      standards_chart: fourth_grade_math
    )

    Standard.create!(
      description: 'solve problems related to perimeter and area of rectangles where dimensions are whole numbers',
      standards_category: geometry,
      title: '4.5(D)',
      meta: 'RS'
    )

    data = StandardsCategory.create!(
      title: 'Data Analysis and Personal Financial Literacy',
      description: 'Data Analysis and Personal Financial Literacy',
      standards_chart: fourth_grade_math
    )

    Standard.create!(
      description: 'represent data on a frequency table, dot plot, or stemand-leaf plot marked with whole numbers and fractions',
      standards_category: data,
      title: '4.9(A)',
      meta: 'RS'
    )
  end
end
