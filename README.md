# POSTGRESQL CDC WAL2JSON DOCKER

## 1. Start PostgreSQL
```bash
docker-compose build
docker-compose up -d
```

## 2. Test Wal2json
```bash
psql -h localhost -U postgres -At -f test/test.sql
```
Test output  
```
CREATE TABLE
CREATE TABLE
init
BEGIN
INSERT 0 1
INSERT 0 1
INSERT 0 1
0/16B4318
0/16B4370
DELETE 2
0/16B44A0
INSERT 0 1
UPDATE 1
COMMIT
psql:test.sql:20: WARNING:  table "table2_without_pk" without primary key or replica identity is nothing
{
        "change": [
                {
                        "kind": "message",
                        "transactional": false,
                        "prefix": "wal2json",
                        "content": "this non-transactional message will be delivered even if you rollback the transaction"
                }
        ]
}
{
        "change": [
                {
                        "kind": "insert",
                        "schema": "public",
                        "table": "table2_with_pk",
                        "columnnames": ["a", "b", "c"],
                        "columntypes": ["integer", "character varying(30)", "timestamp without time zone"],
                        "columnvalues": [1, "Backup and Restore", "2022-05-23 08:24:22.308478"]
                }
                ,{
                        "kind": "insert",
                        "schema": "public",
                        "table": "table2_with_pk",
                        "columnnames": ["a", "b", "c"],
                        "columntypes": ["integer", "character varying(30)", "timestamp without time zone"],
                        "columnvalues": [2, "Tuning", "2022-05-23 08:24:22.308478"]
                }
                ,{
                        "kind": "insert",
                        "schema": "public",
                        "table": "table2_with_pk",
                        "columnnames": ["a", "b", "c"],
                        "columntypes": ["integer", "character varying(30)", "timestamp without time zone"],
                        "columnvalues": [3, "Replication", "2022-05-23 08:24:22.308478"]
                }
                ,{
                        "kind": "message",
                        "transactional": true,
                        "prefix": "wal2json",
                        "content": "this message will be delivered"
                }
                ,{
                        "kind": "delete",
                        "schema": "public",
                        "table": "table2_with_pk",
                        "oldkeys": {
                                "keynames": ["a", "c"],
                                "keytypes": ["integer", "timestamp without time zone"],
                                "keyvalues": [1, "2022-05-23 08:24:22.308478"]
                        }
                }
                ,{
                        "kind": "delete",
                        "schema": "public",
                        "table": "table2_with_pk",
                        "oldkeys": {
                                "keynames": ["a", "c"],
                                "keytypes": ["integer", "timestamp without time zone"],
                                "keyvalues": [2, "2022-05-23 08:24:22.308478"]
                        }
                }
                ,{
                        "kind": "insert",
                        "schema": "public",
                        "table": "table2_without_pk",
                        "columnnames": ["a", "b", "c"],
                        "columntypes": ["integer", "numeric(5,2)", "text"],
                        "columnvalues": [1, 2.34, "Tapir"]
                }
        ]
}
stop
DROP TABLE
DROP TABLE
```