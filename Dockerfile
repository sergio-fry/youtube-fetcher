FROM ruby:2.4.1

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y youtube-dl yarn nodejs unzip

RUN curl -L https://sourceforge.net/projects/mp3gain/files/mp3gain/1.5.2/mp3gain-1_5_2_r2-src.zip/download -o /usr/src/mp3gain.zip && \
    cd /usr/src && unzip mp3gain.zip && make install

WORKDIR /app 
COPY Gemfile* ./
RUN bundle install

COPY . ./

ENV DATABASE_URL=sqlite3:///db/production.sqlite3
ENV RAILS_LOG_TO_STDOUT=true

VOLUME /db
VOLUME /uploads
VOLUME /app/node_modules
VOLUME /app/tmp/cache
VOLUME /app/public/assets

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["web"]
