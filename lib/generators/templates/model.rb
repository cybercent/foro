class Follow < ActiveRecord::Base

  extend Foro::FollowerLib
  extend Foro::FollowScopes

  # NOTE: Follows belong to the "followable" interface, and also to followers
  belongs_to :followable
  belongs_to :follower

  def block!
    self.update_attribute(:blocked, true)
  end

end
