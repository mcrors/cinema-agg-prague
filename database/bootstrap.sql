-- This script configures a new PostgreSQL database and user
-- Usage:
-- psql \
--      -v dbname='your_dbname' \
--      -v mig_user='your_username' \
--      -v mig_pass='your_password' \
--      -f bootstrap.sql

BEGIN;

-- Step 1: Create a new database
CREATE DATABASE :dbname;

-- Step 2: Create a new user with login capabilities
CREATE ROLE :mig_user WITH LOGIN PASSWORD :'mig_pass';
CREATE ROLE :reader WITH LOGIN PASSWORD :'reader_pass' NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT;
CREATE ROLE :scraper WITH LOGIN PASSWORD :'scraper_pass' NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT;
CREATE ROLE :cinema_admin WITH LOGIN PASSWORD :'cinema_admin_pass' NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT;

-- Change connection to the new database
\c :dbname

-- Step 3: Transfer ownership of the database to the new user
ALTER DATABASE :dbname OWNER TO :mig_user;

-- Step 4: Revoke all access from the postgres user to the new database
REVOKE CONNECT ON DATABASE :dbname FROM postgres;

COMMIT;
