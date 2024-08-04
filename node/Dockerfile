FROM ubuntu:24.04

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y \
  build-essential \
  libssl-dev \
  pkg-config \
  nodejs \
  curl \
  git \
  sqlite3 \
  gh

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash