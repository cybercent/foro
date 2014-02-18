require "foro/version"

module Foro
  autoload :Follower,     'foro/follower'
  autoload :Followable,   'foro/followable'
  autoload :FollowerLib,  'foro/follower_lib'
  autoload :FollowScopes, 'foro/follow_scopes'

  require 'foro/railtie' if defined?(Rails) && Rails::VERSION::MAJOR >= 3
end
