## Configuring PostgreSQL Databases

PostgreSQL is a database server used in combination with other servicdes to store data.
```bash
systemctl start postgresql
```

Multiple Version Support is avalible configuration file is `/etc/postgresql/version/cluster-name/`. Each cluster is originally an empty file shell called `postgresql.service` with each new cluster being assign the next port from `5433`, with its own unit: postgresql@version-cluster.service

By default, PostgreSQL listens for incoming connections in two ways: on TCP port 5432 of the localhost interface and on file-based socket `/var/run/postgresql/.s.PGSQL.5432`, configured in `postgresql.conf` with various directives `listen_addresses` addresses to listen to, `port` for the TCP port and `unix_socket_directories` to define the directory where the file-based sockets are created.

The `postgres` user is special and has full administrative privileges over all databases. Client authentication depends on connection type defined in the `pg_hba.conf` configuration file. By default, connections on the file-based socket use the Unix user account as the name of the PostgreSQL user, and it assumes that no further authentication is required. On the TCP connection, PostgreSQL requires the user to authenticate with a username and a password (though not a Unix username/password but rather one managed by PostgreSQL itself).

```sql
createuser -- create user -P prompt for password once created
dropuser -- removes users
createdb -- create database
dropdb -- removes database
-- create a database with some options:
createdb -T database_template -E <encoding(UTF-8)> -0 <owner_username
-- connect to a database with user
psql -h localhost -U username username -- on first logon username used as password
```

"PostgreSQL cluster" is a [Debian-specific addition](https://wiki.debian.org/PostgreSql) and that you will not find any reference to this term in the [official PostgreSQL documentation](https://www.postgresql.org/docs/). Debian's `postgresql-common` package provides multiple tools to manage such clusters: 
**IMPORTANT**  
Whennew major version of PostgreSQL get installed, it will create a new cluster run on the next port(5433), keeping old versiuon util you migrate your databases from old cluster to new one.
```bash
pg_createcluster # create cluster
pg_dropcluster # drop cluster
pg_ctlcluster # 
pg_upgradecluster old-version cluster-name # migrate old cluster
# May need the below for the above to be successful
pg_dropcluster new-version cluster-name 
# Before dropping cluster during migration of a cluster checked it has actually migrated
pg_renamecluster # rename cluster
pg_lsclusters # list clusters
```

## References
 [Debian-specific addition Postgresql](https://wiki.debian.org/PostgreSql) 
 [official PostgreSQL documentation](https://www.postgresql.org/docs/)