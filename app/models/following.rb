class Following < ApplicationModel
  belongs_to :followee, polymorphic: true, counter_cache: :followers_count
  belongs_to :follower, class_name: "User"
end
