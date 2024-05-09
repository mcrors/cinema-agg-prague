-- This script configures a new migration_user for a database
-- Usage:
-- psql -v dbname='your_dbname' -v mig_user='your_username' -f roles/migration.sql

BEGIN:

ALTER DATABASE :dbname OWNER TO :mig_user;
REVOKE CONNECT ON DATABASE :dbname FROM postgres;

COMMIT;
