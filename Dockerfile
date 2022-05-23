FROM postgres:9.6

ENV WAL2JSON_COMMIT_ID=53b548a29ebd6119323b6eb2f6013d7c5fe807ec

RUN apt-get update \
    && apt-get install -f -y --no-install-recommends \
    software-properties-common \
    build-essential \
    pkg-config \
    git \
    postgresql-server-dev-$PG_MAJOR

RUN git clone https://github.com/eulerto/wal2json -b master --single-branch \
    && cd /wal2json \
    && git checkout $WAL2JSON_COMMIT_ID \
    && make && make install \
    && cd / \
    && rm -rf wal2json

# COPY postgresql.conf.sample /usr/share/postgresql/postgresql.conf.sample
# Copy the script which will initialize the replication permissions
COPY /docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
