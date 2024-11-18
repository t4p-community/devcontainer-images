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
  pipx \
  swig \
  unzip \
  libtiff5-dev \
  libjpeg8-dev \
  libopenjp2-7-dev \
  zlib1g-dev \
  libfreetype6-dev \
  liblcms2-dev \
  libwebp-dev \
  tcl8.6-dev \
  tk8.6-dev \
  python3-tk \
  libharfbuzz-dev \
  libfribidi-dev \
  libxcb1-dev \
  cmake \
  wget \
  libopenblas-dev \
  liblapack-dev \
  libgflags-dev \
  gfortran \
  libpcre3-dev \
  automake \
  autoconf \
  libtool \
  bison

WORKDIR /g
RUN wget https://github.com/swig/swig/archive/refs/tags/v4.1.0.tar.gz
RUN tar -xzf v4.1.0.tar.gz
WORKDIR /g/swig-4.1.0
RUN ./autogen.sh && ./configure && make && make install

RUN pipx ensurepath
RUN pipx install mypy
RUN pipx install ruff
