require_dependency 'boards_controller'

module RedmineDanthes
  module Patches
    module BoardsControllerPatch

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

unless BoardsController.included_modules.include?(RedmineDanthes::Patches::BoardsControllerPatch)
  BoardsController.send(:include, RedmineDanthes::Patches::BoardsControllerPatch)
end
