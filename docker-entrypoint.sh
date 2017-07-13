#!/bin/bash
set -e

if [ "$1" = 'web' ]; then
  rm -rf tmp/pids/*
  bundle exec rake db:create db:migrate
  bundle exec rails server puma -p 80 --binding 0.0.0.0
fi

if [ "$1" = 'test' ]; then
  echo 'Specs...'
  export RAILS_ENV=test
  bundle exec rake db:create db:migrate
  bundle exec rspec

  curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
  chmod +x ./cc-test-reporter

  ./cc-test-reporter after-build -r $CC_TEST_REPORTER_ID

  exit 0
fi

exec "$@"
