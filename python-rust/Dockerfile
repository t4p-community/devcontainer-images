FROM ubuntu:22.04

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y \
  build-essential \
  curl \
  git \
  gh \
  python3 \
  python3-venv \
  python3-pip \
  python-is-python3

RUN /usr/bin/python3 -m pip install --upgrade pip mypy ruff

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN /root/.cargo/bin/rustup install nightly
RUN /root/.cargo/bin/rustup component add rustfmt
RUN /root/.cargo/bin/rustup component add rustfmt --toolchain nightly
RUN /root/.cargo/bin/rustup component add clippy 
RUN /root/.cargo/bin/rustup component add clippy --toolchain nightly
RUN /root/.cargo/bin/rustup default nightly

ENV PATH="/root/.cargo/bin:$PATH"
