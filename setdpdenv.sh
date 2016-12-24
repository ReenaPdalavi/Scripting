#!/bin/bash
export SQL_BASE_DIR="/home/userslmt/serverstat_sql"
export DPD_SQL_BASE_DIR="/home/userslmt/serverstat_sql"
#export DPD_SQL_BASE_DIR="/home/userxfer/serverstat/db/"
export DBlogin="userdpd"
export DBPwd="hdpd2011"
export CURRENTDB="DPDSYSTEMS"
DPD_SQL_TABLE_MAP="$DPD_SQL_BASE_DIR/sql_db/config/dpd_sql_tables.map"
DPD_SCRATCH=/home/userslmt/TEMP/Scratch_sql
#DPD_SCRATCH=/home/userslmt/TEMP/scratch_sql
DPD_SQL_SCRATCH=/home/userslmt/TEMP/scratch_sql
DPD_MASTER_DB=/home/userslmt/serverstat/db
DPD_XFER_DB=/home/userxfer/serverstat/db
