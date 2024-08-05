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
  gh \
  python3 \
  python3-venv \
  python3-pip \
  python3-full \
  python-is-python3 \
  pipx

RUN pipx ensurepath

RUN pipx install --upgrade pip mypy ruff
