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


        def receive_async_notifications?
          self.custom_field_values.each do |custom|
            if custom.custom_field.name == 'Receive Async Notifications'
              return custom.value
            end
          end
          return true if admin?
          return false
        end

      end


    end
  end
end

unless User.included_modules.include?(RedmineDanthes::Patches::UserPatch)
  User.send(:include, RedmineDanthes::Patches::UserPatch)
end
