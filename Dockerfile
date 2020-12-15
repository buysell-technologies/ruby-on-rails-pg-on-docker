FROM ruby:2.7.1
ENV LANG C.UTF-8
ENV TZ=Asia/Tokyo

RUN /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get update -qq \
    && apt-get install -y build-essential nodejs postgresql-client git

ENV APP_HOME /var/src/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock

ENV BUNDLE_DISABLE_SHARED_GEMS 1
RUN bundle install -j4
