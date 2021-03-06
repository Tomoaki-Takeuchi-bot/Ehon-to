# use ruby version 2.6
FROM ruby:2.6

# using japanese on rails console
ENV LANG C.UTF-8

# remove warn
ENV DEBCONF_NOWARNINGS yes
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE yes
ENV XDG_CACHE_HOME /tmp
EXPOSE 3000

# install package to docker container
# buid-essential: build tool, libpq-dev: for postgres, less: command
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    vim \
    less

# install yarn
RUN apt-get install apt-transport-https
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# setting work directory
RUN mkdir /app
WORKDIR /app

# setting environment value
ENV HOME /app

# set current directory
COPY . /app

# bundle install
RUN bundle install

# yarn install
RUN yarn install

# Webpacker compile and migrate DB
CMD RAILS_ENV=production bundle exec rails webpacker:compile && \
    RAILS_ENV=production bundle exec rails db:migrate && \
    bundle exec rails s -p '3000' -b '0.0.0.0' -e production
