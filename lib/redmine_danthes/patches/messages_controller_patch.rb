require_dependency 'messages_controller'

module RedmineDanthes
  module Patches
    module MessagesControllerPatch

      def self.included(base)
        base.class_eval do
          unloadable

          helper :danthes
          helper :bootstrap
        end
      end

    end
  end
end

unless MessagesController.included_modules.include?(RedmineDanthes::Patches::MessagesControllerPatch)
  MessagesController.send(:include, RedmineDanthes::Patches::MessagesControllerPatch)
end
