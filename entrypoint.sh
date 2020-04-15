#!/bin/bash

# Start the script to create the DB and user
$CONFIG_PATH/configure-db.sh &

# Start SQL Server
/opt/mssql/bin/sqlservr
