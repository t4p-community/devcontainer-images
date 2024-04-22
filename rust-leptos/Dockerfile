FROM ubuntu:22.04

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y \
  build-essential \
  libssl-dev \
  pkg-config \
  nodejs \
  curl \
  git \
  gh

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

RUN /root/.cargo/bin/rustup install nightly
RUN /root/.cargo/bin/rustup component add rustfmt
RUN /root/.cargo/bin/rustup component add rustfmt --toolchain nightly
RUN /root/.cargo/bin/rustup component add clippy 
RUN /root/.cargo/bin/rustup component add clippy --toolchain nightly

RUN /root/.cargo/bin/rustup default nightly
RUN /root/.cargo/bin/cargo install cargo-leptos
RUN /root/.cargo/bin/cargo install trunk
RUN /root/.cargo/bin/cargo install sqlx-cli
RUN /root/.cargo/bin/cargo install leptosfmt
RUN /root/.cargo/bin/rustup target add wasm32-unknown-unknown


ENV PATH="/root/.cargo/bin:$PATH"
