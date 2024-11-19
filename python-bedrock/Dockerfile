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
  python3-dev \
  python3-venv \
  python3-pip \
  python3-full \
  python-is-python3 \
  pipx \
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
RUN ln -s /usr/local/bin/swig /usr/bin/swig

WORKDIR /g
RUN wget https://github.com/facebookresearch/faiss/archive/refs/tags/v1.7.4.tar.gz
RUN tar -xzf v1.7.4.tar.gz
WORKDIR /g/faiss-1.7.4
RUN python3 -m venv /venv && \
    /venv/bin/pip install numpy && \
    cmake -B build -DFAISS_ENABLE_PYTHON=ON \
                  -DFAISS_ENABLE_GPU=OFF \
                  -DFAISS_OPT_LEVEL=generic \
                  -DBUILD_SHARED_LIBS=ON \
                  -DPython_EXECUTABLE="/venv/bin/python" \
                  -DPython_INCLUDE_DIRS=$(/venv/bin/python -c "from sysconfig import get_paths; print(get_paths()['include'])") \
                  -DPython_LIBRARIES=$(/venv/bin/python-config --ldflags | awk '{print $1}')
RUN cmake --build build
RUN cmake --install build

WORKDIR /g/faiss-1.7.4/build/faiss/python
RUN /venv/bin/pip install .

WORKDIR /g
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install



