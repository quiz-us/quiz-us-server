class Question < ApplicationRecord
  has_many :taggings

  has_many :tags,
    through: :taggings,
    source: :tag
end
