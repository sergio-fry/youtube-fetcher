FROM ruby:2.4

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn nodejs unzip

RUN apt-get update && apt-get install -y ffmpeg python-pip
RUN pip install --upgrade youtube_dl

WORKDIR /app 

COPY . ./

ENV DATABASE_URL=sqlite3:///db/production.sqlite3

ENV RAILS_ENV=production

ENV RAILS_LOG_TO_STDOUT=true
ENV MAX_EPISODES_TO_STORE=50

VOLUME /app/node_modules
VOLUME /app/tmp/youtube
VOLUME /db
VOLUME /uploads
# VOLUME /usr/local/bundle

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["web"]
