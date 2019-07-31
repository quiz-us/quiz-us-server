class Tag < ApplicationRecord
  has_many :taggings
  has_many :questions,
    through: :taggings,
    source: :question
  
end
