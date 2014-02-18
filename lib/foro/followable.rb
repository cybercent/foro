module Foro #:nodoc:
  module Followable

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def followable
        has_many :followings, :as => :followable, :dependent => :destroy, :class_name => 'Follow'
        include Foro::Followable::InstanceMethods
        include Foro::FollowerLib
      end
    end

    module InstanceMethods

      # Returns the number of followers a record has.
      def followers_count
        self.followings.unblocked.count
      end

      def respond_to?(m, include_private = false)
        super || m.to_s[/count_(.+)_followers/] || m.to_s[/(.+)_followers/]
      end

      def blocked_followers_count
        self.followings.blocked.count
      end

      # Returns the followings records scoped
      def followers_scoped
        self.followings.includes(:follower)
      end

      def followers(options={})
        followers_scope = followers_scoped.unblocked
        followers_scope = apply_options_to_scope(followers_scope, options)
        followers_scope.to_a.collect{|f| f.follower}
      end

      def blocks(options={})
        blocked_followers_scope = followers_scoped.blocked
        blocked_followers_scope = apply_options_to_scope(blocked_followers_scope, options)
        blocked_followers_scope.to_a.collect{|f| f.follower}
      end

      # Returns true if the current instance is followed by the passed record
      # Returns false if the current instance is blocked by the passed record or no follow is found
      def followed_by?(follower)
        self.followings.unblocked.for_follower(follower).first.present?
      end

      def block(follower)
        get_follow_for(follower) ? block_existing_follow(follower) : block_future_follow(follower)
      end

      def unblock(follower)
        get_follow_for(follower).try(:delete)
      end

      def get_follow_for(follower)
        self.followings.for_follower(follower).first
      end

      private

      def block_future_follow(follower)
        Follow.create(:followable => self, :follower => follower, :blocked => true)
      end

      def block_existing_follow(follower)
        get_follow_for(follower).block!
      end

    end

  end
end
