-- This script configures a new migration_user for a database
-- Usage:
-- psql -v dbname='your_dbname' -v mig_user='your_username' -f roles/migration.sql

-- This script configures a new migration_user for a database idempotently
-- Usage:
-- psql -v dbname='your_dbname' -v mig_user='your_username' -f roles/migration.sql

DO $$
BEGIN
    -- Change the database owner only if it's not already owned by mig_user
    IF (SELECT pg_database.datname FROM pg_database JOIN pg_roles ON pg_database.datdba = pg_roles.oid
        WHERE pg_database.datname = :dbname AND pg_roles.rolname <> :mig_user) IS NOT NULL THEN
        ALTER DATABASE :dbname OWNER TO :mig_user;
    END IF;

    -- Revoke connect from postgres only if it has the permission
    IF EXISTS (SELECT 1 FROM pg_catalog.pg_database WHERE datname = :dbname AND has_database_privilege('postgres', :dbname, 'CONNECT')) THEN
        REVOKE CONNECT ON DATABASE :dbname FROM postgres;
    END IF;
END $$;
