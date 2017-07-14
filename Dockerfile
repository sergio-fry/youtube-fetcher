FROM ruby:2.4.1

RUN apt update && apt install -y youtube-dl

WORKDIR /app 
COPY Gemfile* ./
RUN bundle install
COPY . ./

ENV DATABASE_URL=sqlite3:///db/production.sqlite3

VOLUME /db
VOLUME /uploads

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["web"]
