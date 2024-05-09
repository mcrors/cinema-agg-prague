#!/bin/bash

source .env

# Run the SQL setup script using the admin user's credentials
export PGHOST=$DB_HOST
export PGPORT=$POSTGRES_PORT
export PGUSER=$ADMIN_USER_NAME
export PGPASSWORD=$ADMIN_USER_PASS
export PGDATABASE="postgres"

# Create the database
psql -v dbname=$DB_NAME -f bootstrap_db.sql


# Create the roles
declare -A roleList
roleList[$MIGRATION_USER_NAME]=$MIGRATION_USER_PASS
roleList[$READER_USER_NAME]=$READER_USER_PASS
roleList[$SCRAPER_USER_NAME]=$SCRAPER_USER_PASS
roleList[$CINEMA_ADMIN_USER_NAME]=$CINEMA_ADMIN_USER_PASS

for role in "${!roleList[@]}"; do
    psql -v rolename=$role -v rolepass={roleList[$key]} bootstrap_roles.sql
done

# Grant access to the migration user
if mig_user is not already owner of database
    psql -v dbname=$DB_NAME -v mig_user=$MIGRATION_USER_NAME -f roles/migration.sql
fi

# Switch user to migration user and database to our database
export PGUSER=$MIGRATION_USER_NAME
export PGPASSWORD=$MIGRATION_USER_PASS
export PGDATABASE=$DB_NAME

# Create tables and views

# Grant access to roles
