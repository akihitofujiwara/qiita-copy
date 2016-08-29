class Tag < ApplicationModel
  has_many :taggings, dependent: :destroy
  has_many :items, through: :taggings, source: :taggable, source_type: "Item"
  has_many :followings, as: :followee, dependent: :destroy
  has_many :followers, through: :followings
end

