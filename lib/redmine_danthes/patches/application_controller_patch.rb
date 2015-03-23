require_dependency 'application_controller'

module RedmineDanthes
  module Patches
    module ApplicationControllerPatch

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

unless ApplicationController.included_modules.include?(RedmineDanthes::Patches::ApplicationControllerPatch)
  ApplicationController.send(:include, RedmineDanthes::Patches::ApplicationControllerPatch)
end
