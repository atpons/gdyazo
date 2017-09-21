FROM alpine:3.4
VOLUME /opt/gdyazo
WORKDIR /opt/gdyazo
ADD ./Gemfile /opt/gdyazo/

ENV RUNTIME_PACKAGES="ruby ruby-dev python"

RUN apk add --no-cache ruby ruby-dev ruby-json ca-certificates python

RUN set -x \
  && apk upgrade --no-cache \ 
  && apk add --no-cache --virtual build-dependencies \
    build-base \
  && apk add --no-cache \
    libxml2-dev \
    libxslt-dev \
  && gem install nokogiri --no-rdoc --no-ri \
    -- --use-system-libraries \
    --with-xml2-config=/usr/bin/xml2-config \
    --with-xslt-config=/usr/bin/xslt-config \
  && apk del build-dependencies

RUN gem install bundle --no-rdoc --no-ri && bundle install
CMD ["python", "server.py"]
