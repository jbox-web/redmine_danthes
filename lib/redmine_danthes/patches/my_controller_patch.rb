require_dependency 'my_controller'

module RedmineDanthes
  module Patches
    module MyControllerPatch

      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
        end
      end


      module InstanceMethods

        def notifications
          render json: User.current.subscribed_channels
        end

      end


    end
  end
end

unless MyController.included_modules.include?(RedmineDanthes::Patches::MyControllerPatch)
  MyController.send(:include, RedmineDanthes::Patches::MyControllerPatch)
end
