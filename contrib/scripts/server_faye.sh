#!/bin/bash

# You should place this script in user's home bin dir like :
# /home/redmine/bin/server_faye.sh
#
# Normally the user's bin directory should be in the PATH.
# If not, add this in /home/redmine/.profile :
#
# ------------------>8
# #set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/bin" ] ; then
#   PATH="$HOME/bin:$PATH"
# fi
# ------------------>8
#
#
# This script *must* be run by the Redmine user so
# switch user *before* running the script :
# root$ su - redmine
#
# Then :
# redmine$ server_faye.sh start
# redmine$ server_faye.sh stop
# redmine$ server_faye.sh restart

SERVER_NAME="redmine-faye"

RAILS_ENV="production"

REDMINE_PATH="$HOME/redmine"
CONFIG_FILE="$REDMINE_PATH/config/danthes_thin.yml"

PID_FILE="$REDMINE_PATH/tmp/pids/faye.pid"

export BUNDLE_GEMFILE="$REDMINE_PATH/Gemfile"

function start () {
  echo "Start Faye/Thin Server..."
  bundle exec thin --config $CONFIG_FILE \
                   --pid $PID_FILE \
                   --tag $SERVER_NAME \
                   --chdir $REDMINE_PATH \
                   --daemonize \
                   start
  echo "Done"
}

function stop () {
  echo "Stop Faye/Thin Server..."
  bundle exec thin --config $CONFIG_FILE \
                   --pid $PID_FILE \
                   stop
  echo "Done"
}

case "$1" in
  start)
    start
  ;;
  stop)
    stop
  ;;
  restart)
    stop
    start
  ;;
  *)
    echo "Usage : $0 {start|stop|restart}"
  ;;
esac
