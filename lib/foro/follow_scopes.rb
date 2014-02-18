module Foro #:nodoc:
  module FollowScopes

    def for_follower(follower)
      where(:follower_id => follower.id)
    end

    def for_followable(followable)
      where(:followable_id => followable.id)
    end

    def recent(from)
      where(["created_at > ?", (from || 2.weeks.ago).to_s(:db)])
    end

    def descending
      order("follows.created_at DESC")
    end

    def unblocked
      where(:blocked => false)
    end

    def blocked
      where(:blocked => true)
    end

  end
end
