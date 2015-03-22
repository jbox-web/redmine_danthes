## ![logo](https://raw.github.com/jbox-web/redmine_danthes/gh-pages/images/logo.png) Redmine d'Anthès Plugin

### A Redmine plugin which makes sending asynchronous notifications easy ;)

This plugin allows straightforward integration of [d'Anthès](https://github.com/dotpromo/danthes) within Redmine.

## Requirements

* Ruby 2.0.x
* a working [Redmine](http://www.redmine.org/) installation
* a working Redis server

## Installation

    ## Before install the plugin, stop Redmine!

    # Clone plugin
    root# su - redmine
    redmine$ cd REDMINE_ROOT/plugins
    redmine$ git clone https://github.com/jbox-web/redmine_danthes.git

    # Copy Danthes config file to Redmine config dir
    redmine$ cd redmine_danthes/
    redmine$ cp config/danthes*.yml ../../config/

    # Copy ```danthes.ru``` Rack script to Redmine root dir
    redmine$ cp danthes.ru ../../

    # Install gems
    redmine$ cd REDMINE_ROOT
    redmine$ bundle install

    ## After install the plugin, start Redmine!

## Configuration

You **must** configure d'Anthès by editing ```config/danthes.yml``` file.

You will have to set a secret to secure your connection with Faye and the Redmine url (for instance http://redmine.example.net).

You **must** also configure your webserver to redirect Faye requests :

Nginx config :

Add this in ```server``` section :

    location /faye {
      access_log   /data/logs/nginx/faye.access.log;
      error_log    /data/logs/nginx/faye.error.log;

      proxy_pass http://127.0.0.1:9292;

      proxy_http_version 1.1;

      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection $connection_upgrade;

      proxy_set_header X-Real-IP  $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto https;
      proxy_set_header Host $http_host;

      gzip off;
      expires off;

      chunked_transfer_encoding off;
      proxy_buffering           off;
      proxy_cache               off;
      proxy_redirect            off;
      proxy_send_timeout        850000;
      proxy_read_timeout        850000;
      proxy_connect_timeout     850000;
    }

Add this outside of ```server``` section :

    map $http_upgrade $connection_upgrade {
      default upgrade;
      ''      close;
    }

## Start d'Anthès/Faye!

    root# su - redmine
    redmine$ cd REDMINE_ROOT
    redmine$ rackup danthes.ru -s thin -E production

You're done!

Now you may need to add your own notifications channels and events, see below!

## Plugin developpers

If you want to integrate Faye async notifications in your plugin you need to register your own channels and events in your ```init.rb``` file : each channel can have many events. It may also have an optional ```target``` parameter which can be a string or a Proc.

    ## it must be OUTSIDE of the Redmine::Plugin.register block

    AsyncNotifications.register_channel :channel_test do
      target Proc.new { User.current.login }
      event  :event1
      event  :event2
      event  :event3
    end

    AsyncNotifications.register_channel :broadcast do
      target 'broadcast'
      event  :event1
      event  :event2
      event  :event3
    end

The rest is handled by the plugin ;)

To check that it's working go in Redmine and load any page. Then edit with Firebug. At the bottom you should have something like that :

    <div data-url="/my/notifications" id="notifications" style="display: none;">
      <script type="text/javascript">
        if (typeof Danthes != 'undefined') { Danthes.sign({"server":"http://redmine.example.net/faye","timestamp":1427061870776,"channel":"/channel_test/admin","signature":"8416c90289dbdbd35130da4018d376b5469c1793"}) }
      </script>
    </div>
    <script>
      $(document).ready(function() { setAsyncNotifications(); });
    </script>

You should also see connections to Faye and errors if any.

Note that if your browser or your connection don't support WebSockets it will fallback to long-polling mode automatically.

## Copyrights & License

Redmine d'Anthes is completely free and open source and released under the [MIT License](https://github.com/jbox-web/redmine_pusher_notifications/blob/devel/LICENSE).

Copyright (c) 2015 Nicolas Rodriguez (nrodriguez@jbox-web.com), JBox Web (http://www.jbox-web.com) [![endorse](https://api.coderwall.com/n-rodriguez/endorsecount.png)](https://coderwall.com/n-rodriguez)

## Contribute

You can contribute to this plugin in many ways such as :
* Helping with documentation
* Contributing code (features or bugfixes)
* Reporting a bug
* Submitting translations

You can also donate :)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FBT7E7DAVVEEU)
