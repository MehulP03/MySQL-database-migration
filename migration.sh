#!/bin/bash

#configuration of source db
source_db_host=""
source_db_user=""
source_db_password=""
source_db_name=""

#configuration of tarfet db
target_db_host=""
target_db_user=""
target_db_password=""
target_db_name=""

mysqldump -h "$source_db_host" -u "$source_db_user" -p"$source_db_password" "$source_db_name" > backup.sql

#in case of rds created a backup of orignal file backup.sql>backup.sql.bak
sed -i.bak -e '/SET @MYSQLDUMP_TEMP_LOG_BIN/ s/^/-- /' \
       -e '/SET @@SESSION.SQL_LOG_BIN= 0;/ s/^/-- /' \
       -e '/SET @@GLOBAL.GTID_PURGED/ s/^/-- /' \
       -e '/SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;/ s/^/-- /' \
       backup.sql

mysql -h "$target_db_host" -u "$target_db_user" -p"$target_db_password" "$target_db_name" < backup.sql

#removing the backup file
rm backup.sql

#remove the the backup of orignal file 
# rm backup.sql.bak

echo "Database migration completed successfully!"