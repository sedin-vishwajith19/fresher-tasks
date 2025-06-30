FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

ENV RBENV_ROOT="/root/.rbenv"
ENV PATH="${RBENV_ROOT}/bin:${RBENV_ROOT}/shims:$PATH"

RUN apt-get update && apt-get install -y \
  curl git build-essential libssl-dev libreadline-dev zlib1g-dev \
  libyaml-dev libgdbm-dev libffi-dev libncurses5-dev libtool \
  bison autoconf pkg-config nodejs npm \
  libsqlite3-dev libmariadb-dev default-mysql-client tzdata \
  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT && \
    git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build && \
    $RBENV_ROOT/bin/rbenv install 3.2.2 && \
    $RBENV_ROOT/bin/rbenv global 3.2.2

RUN gem install bundler && \
    gem install rails -v 7.1.3

WORKDIR /myapp

COPY myapp/. .

RUN bundle config set --local silence_root_warning 1 && bundle install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
