#!/bin/bash
set -e

yarn install
# bundle install --jobs=4 
# bundle exec rake assets:precompile

if [ "$1" = 'web' ]; then
  rm -rf tmp/pids/*

  rm -rf public/uploads/
  ln -s /uploads public/uploads

  bundle exec rake db:migrate
  bundle exec rails server puma -p 80 --binding 0.0.0.0
fi

if [ "$1" = 'worker' ]; then
  rm -rf tmp/pids/*

  rm -rf public/uploads/
  ln -s /uploads public/uploads

  bundle exec rake db:migrate

  export SCHEDULER_CONFIGURE=true
  export QUEUES=default,high_priority,low_priority 
  bundle exec rake jobs:work
fi

exec "$@"
