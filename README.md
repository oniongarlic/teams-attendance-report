# Teams attendance summary graph generator

Getting nice looking simple statistics from Teams Live events can be a bit annoying as 
all it gives you is a very raw csv dump of joins/leaving. Of course you can dump it into Excel or
Power Bi or something cumbersome like that, but using a GUI gets annoying fast.

This collection of simple shell script, a bit of duckdb SQL and gnuplot generates a nice, and
simple summary graphs of attendance. Currently generates graphs for

* Attendance, Joins and Leaving over time
* Attendee domains with counts

Requires:
* gnuplot
* duckdb
