#!/bin/sh

export PG_PREFIX=/usr/local/pgsql
export PG_DATA=$PG_PREFIX/data
export PG_BIN=$PG_PREFIX/bin
export POSTGRESQL_CONF_PATH=$PG_DATA/postgresql.conf
export PGHBA_CONF_PATH=$PG_DATA/pg_hba.conf
export SC_PATH=$PG_DATA/server.crt
export SK_PATH=$PG_DATA/server.key

is_postgres_running() {
    /usr/local/pgsql/bin/pg_ctl -D $PG_DATA status > /dev/null 2>&1
    return $?
}

if [ ! -f /usr/local/pgsql/data/PG_VERSION ]; then

    $PG_BIN/initdb -D $PG_DATA

    openssl req -new -x509 -days 36500 -nodes -out $SC_PATH -keyout $SK_PATH -subj "/C=NA/ST=NA/L=NA/O=NA/OU=NA/CN=locahost"
    chmod 644 $SC_PATH
    chmod 600 $SK_PATH
    chown postgres:postgres $SC_PATH
    chown postgres:postgres $SK_PATH

    sed -i "s/^#listen_addresses = 'localhost'/listen_addresses = '\*'/" $POSTGRESQL_CONF_PATH
    sed -i "s/^#port = 5432/port = 5432/" $POSTGRESQL_CONF_PATH
    sed -i "s/^#ssl = off/ssl = on/" $POSTGRESQL_CONF_PATH

    /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l /usr/local/pgsql/data/logfile start

    while ! is_postgres_running; do
        echo "PostgreSQL is not running..."
        sleep 1
    done

    $PG_BIN/psql -U postgres -c "CREATE ROLE student WITH LOGIN PASSWORD 'sqlDbP@ss!';"
    $PG_BIN/psql -U postgres -c "ALTER ROLE student WITH SUPERUSER;"
    $PG_BIN/psql -U postgres -c "ALTER ROLE student CREATEDB;"
    $PG_BIN/psql -U postgres -c "ALTER ROLE student CREATEROLE;"
    $PG_BIN/psql -U postgres -c "ALTER ROLE student BYPASSRLS;"

    /usr/local/pgsql/bin/createdb -U postgres student 

    $PG_BIN/psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE student TO student;"
    $PG_BIN/psql -U postgres -c "GRANT ALL PRIVILEGES ON SCHEMA public TO student;"

    for f in ./sql/*.sql; do
        echo "Executing $f..."
        $PG_BIN/psql -U postgres -d student -a -f $f
    done

    /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l /usr/local/pgsql/data/logfile stop

    while is_postgres_running; do
        echo "PostgreSQL is still running..."
        sleep 1
    done

    sed -i '/# IPv6 local connections:/i hostssl all student 0.0.0.0/0 trust' $PGHBA_CONF_PATH
fi

exec /usr/local/pgsql/bin/postgres -D /usr/local/pgsql/data
