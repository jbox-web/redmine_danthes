module DanthesHelper

  def render_user_subscribed_channels
    s = ''
    User.current.subscribed_channels.each do |channel|
      s << subscribe_to(channel)
    end
    s.html_safe
  end

end
