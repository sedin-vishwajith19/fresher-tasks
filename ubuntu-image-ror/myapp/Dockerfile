FROM ruby:3.2

RUN apt-get update -qq && apt-get install -y \
    nodejs \
    default-mysql-client \
    libmariadb-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /myapp

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY . .


CMD ["rails", "server", "-b", "0.0.0.0"]
