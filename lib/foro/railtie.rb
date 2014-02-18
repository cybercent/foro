require 'foro'
require 'rails'

module Foro
  class Railtie < Rails::Railtie

    initializer "foro.active_record" do |app|
      ActiveSupport.on_load :active_record do
        include Foro::Follower
        include Foro::Followable
      end
    end

  end
end
