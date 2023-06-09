#!/bin/bash

FTS=$1
ETS=$2
CSVFILE=$3
DB=attendance-database.db

OSUFFIX=${FTS//[[:blank:]]/}

echo $OSUFFIX

if [ ! -f attendance-database.db ]; then
 echo "Init db..."
 duckdb -no-stdin -init tables.sql attendance-database.db
fi

if [ ! -z ${CSVFILE} ]; then
 echo "Importing"
 duckdb -c "set TimeZone='UTC';insert into attendance (sid, pid, name, useragent, etime, action, role) select * from read_csv_auto('${CSVFILE}', types=[VARCHAR, VARCHAR, VARCHAR, VARCHAR, TIMESTAMP, VARCHAR, VARCHAR]);" attendance-database.db
fi

echo "Summary..."
duckdb -c "copy (select tsm,ua as Attendance,uj as 'Join', ul as 'Left' from summary where tsm>='${FTS}' and tsm<='${ETS}' order by tsm) to 'summary.csv' (HEADER, DELIMITER ',')" attendance-database.db

echo "Domains..."
duckdb -c "copy (select case when domain='' then 'Anonymous user' else domain end as domain,count(*) as c from domains where tsm>='${FTS}' and tsm<='${ETS}' group by domain order by c desc) to 'domains.csv' (HEADER, DELIMITER ',')" attendance-database.db

M=`duckdb -column -noheader -s "select max(ua) as m from summary where tsm>='${FTS}' and tsm<='${ETS}'" attendance-database.db`

gnuplot -e "fileout='summary-${OSUFFIX}.png'; filecsv='summary.csv'; set title 'Summary for event ${FTS} max=${M}';" -p summary.gnuplot

gnuplot -e "fileout='domains-${OSUFFIX}.png'; filecsv='domains.csv'; set title 'Attendee domains for event ${FTS}';" -p domains.gnuplot
