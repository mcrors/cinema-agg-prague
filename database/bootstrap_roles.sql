-- This script creates roles
-- Usage:
-- psql -v rolename='your_role_name' -v rolepass='your_role_password' -f bootstrap_roles.sql
DO $$
BEGIN;

EXECUTE FORMAT('CREATE ROLE %I WITH LOGIN PASSWORD %L NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT', :rolename, :rolepass);
--        EXECUTE FORMAT('ALTER ROLE %I WITH PASSWORD %L  NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT', :rolename, :rolepass);

END$$;
