## ![logo](https://raw.github.com/jbox-web/redmine_danthes/gh-pages/images/redmine_logo.png) Redmine d'Anthès Plugin

[![GitHub license](https://img.shields.io/github/license/jbox-web/redmine_danthes.svg)](https://github.com/jbox-web/redmine_danthes/blob/devel/LICENSE)
[![GitHub release](https://img.shields.io/github/release/jbox-web/redmine_danthes.svg)](https://github.com/jbox-web/redmine_danthes/releases/latest)
[![Code Climate](https://codeclimate.com/github/jbox-web/redmine_danthes.png)](https://codeclimate.com/github/jbox-web/redmine_danthes)
[![Build Status](https://travis-ci.org/jbox-web/redmine_danthes.svg?branch=devel)](https://travis-ci.org/jbox-web/redmine_danthes)
[![Dependency Status](https://gemnasium.com/jbox-web/redmine_danthes.svg)](https://gemnasium.com/jbox-web/redmine_danthes)
[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/jbox-web/redmine_danthes?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FBT7E7DAVVEEU)

### A Redmine plugin which makes sending asynchronous notifications easy ;)

This plugin allows straightforward integration of [d'Anthès](https://github.com/dotpromo/danthes) within Redmine to display nice notifications in Growl style.

It relies on :

* [d'Anthès](https://github.com/dotpromo/danthes) which provide easy [Faye backend](http://faye.jcoglan.com/) integration in any Rails application.
* [async_notifications](https://github.com/jbox-web/async_notifications) gem so plugins developpers can access to the DSL provided to register their own channels and events (see the doc in the [Wiki](https://github.com/jbox-web/redmine_danthes/wiki)).
* [Redmine Bootstrap Kit](https://github.com/jbox-web/redmine_bootstrap_kit) which provides [Bootstrap Notify](https://github.com/mouse0270/bootstrap-notify).

## Why?

Before switching to d'Anthès and write this plugin, I used [Redmine Pusher Notifications](https://github.com/jbox-web/redmine_pusher_notifications) which does exactly the same job... with the drawback that it depends on [Pusher](https://pusher.com/) service to work (a really nice messaging solution by the way).

With Redmine d'Anthès, this external dependency is removed so you can use async notifications with no limits ! :)

## Installation

Read the documentation and more in the [Wiki](https://github.com/jbox-web/redmine_danthes/wiki).

## Copyrights & License

Redmine d'Anthes is completely free and open source and released under the [MIT License](https://github.com/jbox-web/redmine_danthes/blob/devel/LICENSE).

Copyright (c) 2015 Nicolas Rodriguez (nrodriguez@jbox-web.com), JBox Web (http://www.jbox-web.com) [![endorse](https://api.coderwall.com/n-rodriguez/endorsecount.png)](https://coderwall.com/n-rodriguez)

## Contribute

You can contribute to this plugin in many ways such as :
* Helping with documentation
* Contributing code (features or bugfixes)
* Reporting a bug
* Submitting translations

You can also donate :)
