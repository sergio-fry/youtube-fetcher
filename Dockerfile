FROM ruby:2.4.1

WORKDIR /app 
COPY Gemfile* ./
RUN bundle install
COPY . ./

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["web"]
