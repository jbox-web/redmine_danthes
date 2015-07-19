require_dependency 'attachments_controller'

module RedmineDanthes
  module Patches
    module AttachmentsControllerPatch

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

unless AttachmentsController.included_modules.include?(RedmineDanthes::Patches::AttachmentsControllerPatch)
  AttachmentsController.send(:include, RedmineDanthes::Patches::AttachmentsControllerPatch)
end
