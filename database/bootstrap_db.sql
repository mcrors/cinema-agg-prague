-- This script configures a new PostgreSQL database and user
-- it should be executed by the superuser against the default database (postgres)
-- Usage:
-- psql -v dbname='your_dbname' -f bootstrap_db.sql

BEGIN;

-- Create the database if it doesn't exist
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = :dbname) THEN
        EXECUTE FORMAT('CREATE DATABASE %I', :dbname);
    END IF;
END $$;

COMMIT;
