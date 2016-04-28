require_dependency 'wiki_controller'

module RedmineDanthes
  module Patches
    module WikiControllerPatch

      def self.included(base)
        base.class_eval do
          unloadable

          helper :bootstrap
          helper :danthes
        end
      end

    end
  end
end

unless WikiController.included_modules.include?(RedmineDanthes::Patches::WikiControllerPatch)
  WikiController.send(:include, RedmineDanthes::Patches::WikiControllerPatch)
end
