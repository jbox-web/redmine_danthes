## ![logo](https://raw.github.com/jbox-web/redmine_danthes/gh-pages/images/redmine_logo.png) Redmine d'Anthès Plugin

[![GitHub license](https://img.shields.io/github/license/jbox-web/redmine_danthes.svg)](https://github.com/jbox-web/redmine_danthes/blob/devel/LICENSE)
[![GitHub release](https://img.shields.io/github/release/jbox-web/redmine_danthes.svg)](https://github.com/jbox-web/redmine_danthes/releases/latest)
[![Code Climate](https://codeclimate.com/github/jbox-web/redmine_danthes.png)](https://codeclimate.com/github/jbox-web/redmine_danthes)
[![Build Status](https://travis-ci.org/jbox-web/redmine_danthes.svg?branch=devel)](https://travis-ci.org/jbox-web/redmine_danthes)
[![Dependency Status](https://gemnasium.com/jbox-web/redmine_danthes.svg)](https://gemnasium.com/jbox-web/redmine_danthes)
[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/jbox-web/redmine_danthes?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

### A Redmine plugin which makes sending asynchronous notifications easy ;)

This plugin allows straightforward integration of [d'Anthès](https://github.com/dotpromo/danthes) within Redmine to display nice notifications in Growl style.

It relies on :

* [d'Anthès](https://github.com/dotpromo/danthes) which provide easy [Faye backend](http://faye.jcoglan.com/) integration in any Rails application.
* [async_notifications](https://github.com/jbox-web/async_notifications) gem so plugins developpers can access to the DSL provided to register their own channels and events (see the doc in the [Wiki](https://github.com/jbox-web/redmine_danthes/wiki)).
* [Redmine Bootstrap Kit](https://github.com/jbox-web/redmine_bootstrap_kit) which provides [Bootstrap Notify](https://github.com/mouse0270/bootstrap-notify).

## Why?

Before switching to d'Anthès and write this plugin, I used [Redmine Pusher Notifications](https://github.com/jbox-web/redmine_pusher_notifications) which does exactly the same job... with the drawback that it depends on [Pusher](https://pusher.com/) service to work (a really nice messaging solution by the way).

With Redmine d'Anthès, this external dependency is removed so you can use async notifications with no limits ! :)

## Requirements

* Ruby 2.0.x
* a working [Redmine](http://www.redmine.org/) installation
* a working Redis server

## Installation

Assuming that you have Redmine installed :

```sh
## Before install the plugin, stop Redmine!

# Switch user
root# su - redmine

# First git clone Bootstrap Kit
redmine$ cd REDMINE_ROOT/plugins
redmine$ git clone https://github.com/jbox-web/redmine_bootstrap_kit.git
redmine$ cd redmine_bootstrap_kit/
redmine$ git checkout 0.2.3

# Then Redmine d'Anthes plugin
redmine$ cd REDMINE_ROOT/plugins
redmine$ git clone https://github.com/jbox-web/redmine_danthes.git
redmine$ cd redmine_danthes/
redmine$ git checkout 1.0.0

# Copy Danthes config file to Redmine config dir
redmine$ cp config/danthes*.yml ../../config/

# Copy ```danthes.ru``` Rack script to Redmine root dir
redmine$ cp danthes.ru ../../

# Install gems
redmine$ cd REDMINE_ROOT/
redmine$ bundle install --without development test

## After install the plugin, start Redmine!
```

## Configuration

You **must** configure d'Anthès by editing ```<redmine root>/config/danthes.yml``` file.

You will have to set a secret to secure your connection with Faye and the Redmine URL (for instance http://redmine.example.net).

You **must** also configure your webserver to redirect Faye requests :

##### Nginx config :

Add this in ```server``` section :

```nginx
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
```

Add this outside of ```server``` section :

```nginx
map $http_upgrade $connection_upgrade {
  default upgrade;
  ''      close;
}
```

#### Start d'Anthès/Faye!

```sh
root# su - redmine
redmine$ cd REDMINE_ROOT
redmine$ rackup danthes.ru -s thin -E production
```

You're done!

Now you may need to add your own notifications channels and events, see below!


## Usage

If you want to integrate Faye async notifications in your plugin you need to register your own channels and events in your ```init.rb``` file : each channel can have many events.
It may also have an optional ```target``` parameter which can be a string or a Proc.

```ruby
## This must be OUTSIDE of the Redmine::Plugin.register block

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
```

The rest is handled by the plugin ;)

To check that it's working go in Redmine and load any page. Then edit with Firebug. At the bottom you should have something like that :

```ruby
<div data-url="/my/notifications" id="notifications" style="display: none;">
  <script type="text/javascript">
    if (typeof Danthes != 'undefined') { Danthes.sign({"server":"http://redmine.example.net/faye","timestamp":1427061870776,"channel":"/channel_test/admin","signature":"8416c90289dbdbd35130da4018d376b5469c1793"}) }
  </script>
</div>
<script>
  $(document).ready(function() { setAsyncNotifications(); });
</script>
```

You should also see connections to Faye and check errors if any.

Note that if your browser or your connection don't support WebSockets it will fallback to long-polling mode automatically.

## Contribute

You can contribute to this plugin in many ways such as :
* Helping with documentation
* Contributing code (features or bugfixes)
* Reporting a bug
* Submitting translations
