-- This script creates roles
-- Usage:
-- psql -v rolename='your_role_name' -v rolepass='your_role_password' -f bootstrap_roles.sql

BEGIN;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = :rolename) THEN
        EXECUTE FORMAT('CREATE ROLE %I WITH LOGIN PASSWORD %L NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT', :rolename, :rolepass);
    ELSE
        EXECUTE FORMAT('ALTER ROLE %I WITH PASSWORD %L  NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT', :rolename, :rolepass);
    END IF;
END $$;

COMMIT;
