FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LLVM_CONFIG=/usr/bin/llvm-config-16
ENV CLANG=/usr/bin/clang-16
ENV PG_PREFIX=/usr/local/pgsql


RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y software-properties-common wget

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN add-apt-repository -y 'deb http://apt.llvm.org/noble/ llvm-toolchain-noble main'
RUN add-apt-repository -y 'deb-src http://apt.llvm.org/noble/ llvm-toolchain-noble main'
RUN apt-get update
    
RUN apt-get install -y \
    build-essential pkg-config libicu-dev libreadline-dev zlib1g-dev libssl-dev libxslt-dev \
    uuid-dev libossp-uuid-dev tcl-dev libperl-dev libpython3-dev libllvm-16-ocaml-dev libllvm16 \
    llvm-16 llvm-16-dev llvm-16-doc llvm-16-examples llvm-16-runtime clang-16 clang-tools-16 \
    clang-16-doc libclang-common-16-dev libclang-16-dev libclang1-16 clang-format-16 python3-clang-16 \
    clangd-16 clang-tidy-16 libclang-rt-16-dev libpolly-16-dev libfuzzer-16-dev lldb-16 lld-16 \
    libc++-16-dev libc++abi-16-dev libomp-16-dev libclc-16-dev libunwind-16-dev libmlir-16-dev \
    mlir-16-tools liblld-16-dev libclang-16-dev libllvm16

WORKDIR /build

RUN wget https://ftp.postgresql.org/pub/source/v16.3/postgresql-16.3.tar.bz2
RUN tar -xvjf postgresql-16.3.tar.bz2

WORKDIR /build/postgresql-16.3

RUN ./configure --prefix=$PG_PREFIX --with-perl --with-python --with-tcl --with-llvm --with-ssl=openssl --with-zlib --with-uuid=ossp --with-libxml --with-libxslt
RUN make
RUN make install

ENV PG_BIN=$PG_PREFIX/bin
ENV PG_DATA=$PG_PREFIX/data
ENV POSTGRESQL_CONF_PATH=$PG_DATA/postgresql.conf
ENV PGHBA_CONF_PATH=$PG_DATA/pg_hba.conf
ENV SC_PATH=$PG_DATA/server.crt
ENV SK_PATH=$PG_DATA/server.key
EXPOSE 5432

RUN mkdir $PG_DATA

RUN useradd postgres
RUN chown postgres:postgres $PG_DATA
USER postgres:postgres

RUN $PG_BIN/initdb -D $PG_DATA

RUN openssl req -new -x509 -days 36500 -nodes -out $SC_PATH -keyout $SK_PATH \
    -subj "/C=NA/ST=NA/L=NA/O=NA/OU=NA/CN=locahost"
RUN chmod 644 $SC_PATH
RUN chmod 600 $SK_PATH
RUN chown postgres:postgres $SC_PATH
RUN chown postgres:postgres $SK_PATH

RUN sed -i "s/^#listen_addresses = 'localhost'/listen_addresses = '\*'/" $POSTGRESQL_CONF_PATH
RUN sed -i "s/^#port = 5432/port = 5432/" $POSTGRESQL_CONF_PATH
RUN sed -i "s/^#ssl = off/ssl = on/" $POSTGRESQL_CONF_PATH
RUN sed -i '/# IPv6 local connections:/i hostssl all postgres 0.0.0.0/0 trust' $PGHBA_CONF_PATH

ENTRYPOINT ["/usr/local/pgsql/bin/postgres", "-D", "/usr/local/pgsql/data"]
