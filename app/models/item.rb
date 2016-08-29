class Item < ApplicationModel
  belongs_to :author, class_name: "User"
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :stocks, as: :stockable, dependent: :destroy
  has_many :stockers, through: :stocks
  has_many :comments, as: :commentable, dependent: :destroy

  scope :only_public, -> { where scope: :public }
  scope :recent_stocked, -> { select("items.*, stocks.created_at").joins(:stocks).order('stocks.created_at desc').uniq }

  def tag_list
    tags.map(&:name).join " "
  end

  def tag_list=(tag_list)
    tags.replace(
      tag_list.split(/\s+/).map do |it|
        Tag.find_or_initialize_by name: it
      end
    )
  end
end

