module RedmineDanthes
  module Hooks
    class AddDanthesClientJavascript < Redmine::Hook::ViewListener

      render_on :view_layouts_base_body_bottom, partial: 'layouts/danthes'

    end
  end
end
