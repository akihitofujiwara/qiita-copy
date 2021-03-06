class User < ApplicationModel
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]
  validates :username, presence: true, uniqueness: true
  has_many :items, foreign_key: :author_id, dependent: :destroy
  has_many :stocks, foreign_key: :stocker_id, dependent: :destroy
  has_many :stocked_items, through: :stocks, source: :stockable, source_type: "Item"
  has_many :followings_as_followee, class_name: "Following", as: :followee, dependent: :destroy
  has_many :followers, through: :followings_as_followee
  has_many :followings_as_follower, class_name: "Following", foreign_key: :follower_id, dependent: :destroy
  has_many :followee_tags, through: :followings_as_follower, source: :followee, source_type: "Tag"
  has_many :followee_users, through: :followings_as_follower, source: :followee, source_type: "User"
  has_many :comments, foreign_key: :commenter_id, dependent: :destroy

  class << self
    def new_with_session(params, session)
      super.tap do |u|
        if attrs = session["user_attrs"]
          u.provider = attrs["provider"]
          u.uid = attrs["uid"]
          u.username = attrs["info"]["name"]
          u.icon_url = attrs["info"]["image"]
        end
      end
    end
  end

  def password_required?
    super && provider.blank?
  end

  def feeds
    [
      Tagging.where(tag_id: followee_tags.pluck(:id)),
      Comment.where(commenter_id: (followee_user_ids = followee_users.pluck(:id))),
      Stock.where(stocker_id: followee_user_ids),
      Item.where(author_id: followee_user_ids)
    ].inject(:+).sort_by(&:created_at).reverse
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

