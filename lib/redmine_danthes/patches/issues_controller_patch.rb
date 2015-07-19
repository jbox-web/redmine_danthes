require_dependency 'issues_controller'

module RedmineDanthes
  module Patches
    module IssuesControllerPatch

      def self.included(base)
        base.class_eval do
          unloadable

          helper :danthes
        end
      end

    end
  end
end

unless IssuesController.included_modules.include?(RedmineDanthes::Patches::IssuesControllerPatch)
  IssuesController.send(:include, RedmineDanthes::Patches::IssuesControllerPatch)
end
