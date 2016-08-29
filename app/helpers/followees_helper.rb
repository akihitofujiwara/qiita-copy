module FolloweesHelper
  def follow_link_of(followee)
    if current_user.follows? followee
      link_to "Unfollow", followee_following_path(followee), method: :delete, class: "btn btn-danger"
    else
      link_to "Follow", followee_following_path(followee), method: :post, class: "btn btn-primary"
    end
  end

  def followee_following_path(followee)
    send("#{followee.class.to_s.underscore}_following_path", followee)
  end
end

