module FolloweesHelper
  def followee_following_path(followee)
    send("#{followee.class.to_s.underscore}_following_path", followee)
  end
end

