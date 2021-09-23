#!/bin/bash

db_host=$1
database=$2
db_port="5432"
db_user=$4

psql -h $1 -d $2 -p $db_port -f locks_andor_blocks.sql
