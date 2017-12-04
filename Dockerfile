FROM ruby:2.1.9-alpine
MAINTAINER Nossas <tech@nossas.org>

ENV BUILD_PACKAGES postgresql-dev libxml2-dev libxslt-dev imagemagick imagemagick-dev openssl libpq libffi-dev bash curl-dev libstdc++ tzdata bash ca-certificates build-base ruby-dev libc-dev linux-headers postgresql-client postgresql git sqlite sqlite-dev
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler ruby-irb ruby-bigdecimal ruby-json
ENV RAILS_ENV=production RACK_ENV=production DISABLE_SSL=true

RUN apk update && \
    apk upgrade && \
    apk --update add --virtual build_deps $BUILD_PACKAGES && \
    apk --update add $RUBY_PACKAGES

RUN mkdir /usr/app
WORKDIR /usr/app

COPY Gemfile /usr/app/
COPY Gemfile.lock /usr/app/

RUN gem install bundler
RUN bundle install
COPY . /usr/app

CMD [ "bundle", "exec", "puma", "-C", "config/puma.rb" ]

EXPOSE 3000

RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && echo "America/Sao_Paulo" >  /etc/timezone

RUN set -ex \
  && mkdir -p /usr/app/tmp/cache \
  && mkdir -p /usr/app/tmp/pids \
  && mkdir -p /usr/app/tmp/sockets

