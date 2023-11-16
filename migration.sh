#!/bin/bash

#configuration of source db take input through terminal
echo "Enter the source db host/DNS"
read source_db_host
echo "Enter the source db user"
read source_db_user
echo "Enter the source db password"
read source_db_password
echo "Enter the source db name"
read source_db_name

#hard code
# source_db_host=""
# source_db_user=""
# source_db_password=""
# source_db_name=""


#configuration of tarfet db take input through terminal
echo "Enter target db host/DNS"
read target_db_host
echo "target db user"
read target_db_user
echo "Enter target db password"
read target_db_password
echo "Enter the target db name"
read target_db_name

# #hard code
# target_db_host=""
# target_db_user=""
# target_db_password=""
# target_db_name=""

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