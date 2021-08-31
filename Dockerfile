FROM ruby:3.0.2-alpine3.12 as ruby

## Development
FROM ruby AS dev

ENV BUNDLE_FORCE_RUBY_PLATFORM=1 \
    CFLAGS="-Wno-cast-function-type"

RUN apk update \
    && apk add --no-cache \
        gcc \
        g++ \
        libc-dev \
        linux-headers \
        make \
        postgresql \
        tzdata \
        git \
    && apk add --virtual build-dependencies --no-cache \
        postgresql-dev \
        libxml2-dev \
        build-base \
        curl-dev \
    # https://dustri.org/b/error-loading-shared-library-ld-linux-x86-64so2-on-alpine-linux.html
    && ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

RUN mkdir -p /app
ENV HOME /app

WORKDIR $HOME

COPY ./Gemfile* ./
ARG bundle_install_options="--without development test doc --jobs 4"
RUN bundle config github.https true \
  && bundle install $bundle_install_options \
  && apk del build-dependencies

COPY . /app

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
