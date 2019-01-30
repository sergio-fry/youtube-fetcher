FROM ruby:2.4

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn nodejs unzip

RUN apt-get update && apt-get install -y libav-tools python-pip
RUN pip install --upgrade youtube_dl

RUN curl -L https://sourceforge.net/projects/mp3gain/files/mp3gain/1.5.2/mp3gain-1_5_2_r2-src.zip/download -o /usr/src/mp3gain.zip && \
    cd /usr/src && unzip mp3gain.zip && make install

WORKDIR /app 
COPY Gemfile* ./
RUN bundle install --deployment --without test development --jobs=4 

COPY . ./

ENV DATABASE_URL=sqlite3:///db/production.sqlite3

ENV RAILS_ENV=production
RUN bundle exec rake webpacker:yarn_install
RUN bundle exec rake assets:precompile

ENV RAILS_LOG_TO_STDOUT=true
ENV MAX_EPISODES_TO_STORE=50

VOLUME /db
VOLUME /uploads
VOLUME /app/tmp/youtube

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["web"]
