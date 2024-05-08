-- This script creates a user and grants specific permissions
-- Usage:
-- psql -v username='your_username' -v userpass='your_password' -v dbname='your_dbname' -f reader.sql

BEGIN;

GRANT CONNECT ON DATABASE :dbname TO :username;

-- Change connection to the target database to set specific grants
\c :dbname

-- Revoke all default privileges for the user on all tables and views
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM :username;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM :username;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA public FROM :username;

-- Grant SELECT on the specific view only
GRANT SELECT ON TABLE public.vw_listings TO :username;

COMMIT;
