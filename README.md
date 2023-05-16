# Teams attendance summary graph generator

Getting nice looking simple statistics from Teams Live events can be a bit annoying as 
all it gives you is a very raw csv dump of joins/leaving. Of course you can dump it into Excel or
Power Bi or something cumbersome like that, but using a GUI gets annoying fast.

This collection of simple shell script, a bit of duckdb SQL and gnuplot generates a nice, and
simple summary graphs of attendance. Currently generates graphs for

* Attendance, Joins and Leaving over time
* Attendee domains with counts

As an extra you will also get csv files of the above!

Requires:
* gnuplot
* duckdb

Note: For now, events that overlap are NOT supported.

## Usage:

At first start a duckdb database attendance-database.db will be created using details from tables.sql

Start and end timestamps must always be given and in the format YYYY-MM-DD HH:MM:SS
First parameter is start time, second end time. Third is CSV file to import and is optional.

Importing and generating a report
    ./generate-report.sh '2023-05-11 8:45:00' '2023-05-11 10:15:00' attendee.csv

Generating a report from already imported data
    ./generate-report.sh '2023-05-11 8:45:00' '2023-05-11 10:15:00'

