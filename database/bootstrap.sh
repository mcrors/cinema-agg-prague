#!/bin/bash

# Run the SQL setup script using the admin user's credentials
export PGPASSWORD=$ADMIN_USER_PASS
psql -U $ADMIN_USER_NAME \
    -h $DB_HOST \
    -p $DB_PORT \
    -d postres \
    -v dbname="'$DB_NAME'" \
    -v username="'$MIGRATION_USER_NAME'" \
    -v userpass="'$MIGRATION_USER_PASS'" \
    -f setup.sql
