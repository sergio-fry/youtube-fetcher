#!/bin/bash
set -e

if [ "$1" = 'web' ]; then
  rm -rf tmp/pids/*

  rm -rf public/uploads/
  ln -s /uploads public/uploads

  yarn install
  bundle exec rake assets:precompile db:create db:migrate
  bundle exec rails server puma -p 80 --binding 0.0.0.0
fi

if [ "$1" = 'worker' ]; then
  rm -rf tmp/pids/*

  rm -rf public/uploads/
  ln -s /uploads public/uploads

  bundle exec rake db:create db:migrate

  export QUEUES=default,high_priority,low_priority 
  bundle exec rake jobs:work
fi

if [ "$1" = 'test' ]; then
  echo 'Specs...'
  export RAILS_ENV=test
  yarn install
  bundle exec rake db:create db:migrate
  bundle exec rspec

  exit 0
fi

exec "$@"
