class Tagging < ApplicationModel
  belongs_to :taggable, polymorphic: true
  belongs_to :tag, counter_cache: :taggables_count
  has_many :followings, as: :followee
  has_many :followers, through: :followings
end

