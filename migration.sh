#!/bin/bash

perform_migration(){
    source_db_host=$(yq '.source_database.db_host' config.yaml)
    source_db_user=$(yq '.source_database.db_user' config.yaml)
    source_db_password=$(yq '.source_database.db_password' config.yaml)
    source_db_name=$(yq '.source_database.db_name' config.yaml)

    target_db_host=$(yq '.destination_database.db_host' config.yaml)
    target_db_user=$(yq '.destination_database.db_user' config.yaml)
    target_db_password=$(yq '.destination_database.db_password' config.yaml)
    target_db_name=$(yq '.destination_database.db_name' config.yaml)

    mysqldump -h "$source_db_host" -u "$source_db_user" -p"$source_db_password" "$source_db_name" > backup.sql

    #IN CASE OF RDS  created a backup of orignal file backup.sql>backup.sql.bak and comment this lines
    sed -i.bak -e '/SET @MYSQLDUMP_TEMP_LOG_BIN/ s/^/-- /' \
        -e '/SET @@SESSION.SQL_LOG_BIN;/ s/^/-- /' \
        -e '/SET @@GLOBAL.GTID_PURGED/ s/^/-- /' \
        -e '/SET @@SESSION.SQL_LOG_BIN/ s/^/-- /' \
        backup.sql

    mysql -h "$target_db_host" -u "$target_db_user" -p"$target_db_password" "$target_db_name" < backup.sql

    #removing the backup file
    rm backup.sql

    #remove the the backup of orignal file 
    # rm backup.sql.bak

    echo "Database migration completed successfully!"
}

if [ -f "config.yaml" ]; then
    perform_migration
else
    echo "Error: config.yaml not found!"
    exit 1
fi