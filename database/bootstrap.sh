#!/bin/bash

source .env

# Run the SQL setup script using the admin user's credentials
export PGHOST=$DB_HOST
export PGPORT=$POSTGRES_PORT
export PGUSER=$ADMIN_USER_NAME
export PGPASSWORD=$ADMIN_USER_PASS
export PGDATABASE="postgres"

# Create the database

db_exists=$(psql -tc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'")
if grep -q 1 <<< $db_exists ; then
    echo "Database $DB_NAME already exists"
else
    echo "Creating database: $DB_NAME"
    psql -c "CREATE DATABASE $DB_NAME"
fi

# Create the roles
declare -A roleList
roleList[$MIGRATION_USER_NAME]=$MIGRATION_USER_PASS
roleList[$READER_USER_NAME]=$READER_USER_PASS
roleList[$SCRAPER_USER_NAME]=$SCRAPER_USER_PASS
roleList[$CINEMA_ADMIN_USER_NAME]=$CINEMA_ADMIN_USER_PASS

for role in "${!roleList[@]}"; do
    echo $role
    echo ${roleList[$role]}
    psql -v rolename=$role -v rolepass=${roleList[$role]} -f bootstrap_roles.sql
done


# Check if mig_user is already the owner of the database
IS_OWNER=$(psql -t -A -U postgres -c "SELECT CASE WHEN pg_roles.rolname = '$MIGRATION_USER_NAME' THEN 'yes' ELSE 'no' END FROM pg_database JOIN pg_roles ON pg_database.datdba = pg_roles.oid WHERE pg_database.datname = '$DB_NAME'")

# Grant access to the migration user only if not already the owner
if [ "$IS_OWNER" != "yes" ]; then
    psql -v dbname=$DB_NAME -v mig_user=$MIGRATION_USER_NAME -f roles/migration.sql
fi

# Switch user to migration user and database to our database
export PGUSER=$MIGRATION_USER_NAME
export PGPASSWORD=$MIGRATION_USER_PASS
export PGDATABASE=$DB_NAME

# Create tables and views
psql -f tables/cinema_sites.sql
psql -f tables/cinemas.sql
psql -f tables/movies.sql
psql -f tables/listings.sql

psql -f views/vw_listings.sql

# Grant access to roles
