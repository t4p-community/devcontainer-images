FROM ubuntu:24.04

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
  python3-full \
  python-is-python3 \
  valgrind \
  pipx

RUN pipx ensurepath

RUN pipx install --upgrade pip mypy ruff maturin

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN /root/.cargo/bin/rustup install nightly
RUN /root/.cargo/bin/rustup component add rustfmt
RUN /root/.cargo/bin/rustup component add rustfmt --toolchain nightly
RUN /root/.cargo/bin/rustup component add clippy 
RUN /root/.cargo/bin/rustup component add clippy --toolchain nightly
RUN /root/.cargo/bin/rustup default nightly

ENV PATH="/root/.cargo/bin:$PATH"
