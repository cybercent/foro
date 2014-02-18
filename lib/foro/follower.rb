module Foro #:nodoc:
  module Follower

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def follower
        has_many :follows, :as => :follower, :dependent => :destroy
        include Foro::Follower::InstanceMethods
        include Foro::FollowerLib
      end
    end

    module InstanceMethods

      # Returns true if this instance is following the object passed as an argument.
      def following?(followable)
        0 < Follow.unblocked.for_follower(self).for_followable(followable).count
      end

      # Returns the number of objects this instance is following.
      def follow_count
        Follow.unblocked.for_follower(self).count
      end

      # Creates a new follow record for this instance to follow the passed object.
      # Does not allow duplicate records to be created.
      def follow(followable)
        if self != followable
          self.follows.find_or_create_by(followable_id: followable.id)
        end
      end

      # Deletes the follow record if it exists.
      def stop_following(followable)
        if follow = get_follow(followable)
          follow.destroy
        end
      end

      # returns the follows records to the current instance
      def follows_scoped
        self.follows.unblocked.includes(:followable)
      end

      # Returns the follow records related to this instance with the followable included.
      def all_follows(options={})
        follows_scope = follows_scoped
        follows_scope = apply_options_to_scope(follows_scope, options)
      end

      # Returns the actual records which this instance is following.
      def all_following(options={})
        all_follows(options).collect{ |f| f.followable }
      end

      # Returns a follow record for the current instance and followable object.
      def get_follow(followable)
        self.follows.unblocked.for_followable(followable).first
      end

    end

  end
end
