class Comment < ApplicationModel
  belongs_to :commentable, polymorphic: true, counter_cache: :comments_count
  belongs_to :commenter, class_name: "User"
end
