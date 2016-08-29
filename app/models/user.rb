class User < ApplicationModel
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :items, foreign_key: :author_id, dependent: :destroy
  has_many :stocks, foreign_key: :stocker_id, dependent: :destroy
  has_many :stocked_items, through: :stocks, source: :stockable, source_type: "Item"
  has_many :followings_as_followee, class_name: "Following", as: :followee, dependent: :destroy
  has_many :followers, through: :followings_as_followee
  has_many :followings_as_follower, class_name: "Following", foreign_key: :follower_id, dependent: :destroy
  has_many :followee_tags, through: :followings_as_follower, source: :followee, source_type: "Tag"
  has_many :followee_users, through: :followings_as_follower, source: :followee, source_type: "User"
  has_many :comments, foreign_key: :commenter_id, dependent: :destroy

  def followee_items
    Item
      .only_public
      .joins(:tags)
      .joins(:author)
      .joins('left join followings as ft on ft.followee_type = \'Tag\' and ft.followee_id = tags.id')
      .joins('left join followings as fu on fu.followee_type = \'User\' and fu.followee_id = users.id')
      .where('ft.follower_id = ? or fu.follower_id = ?', id, id)
      .uniq
      .latest(10)
  end

  def stocks?(item)
    stocked_items.include? item
  end

  def stock(item)
    stocked_items << item unless stocks? item
  end

  def unstock(item)
    stocked_items.destroy item if stocks? item
  end

  def follows?(followee)
    followee.followers.include? self
  end

  def follow(followee)
    followee.followers << self unless follows? followee
  end

  def unfollow(followee)
    followee.followers.destroy self if follows? followee
  end
end

