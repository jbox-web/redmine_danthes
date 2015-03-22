require_dependency 'user'

module RedmineDanthes
  module Patches
    module UserPatch

      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
        end
      end


      module InstanceMethods

        def subscribed_channels
          AsyncNotifications.channels.map(&:name)
        end

      end


    end
  end
end

unless User.included_modules.include?(RedmineDanthes::Patches::UserPatch)
  User.send(:include, RedmineDanthes::Patches::UserPatch)
end
