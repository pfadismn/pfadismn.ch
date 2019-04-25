#!/bin/sh
set -e

[ ! -e /app/tmp/pids/server.pid ] || rm /app/tmp/pids/server.pid
bundle check || bundle install
bin/rails db:migrate:status || bin/rails db:create db:migrate RAILS_ENV=$RAILS_ENV

exec "$@"
