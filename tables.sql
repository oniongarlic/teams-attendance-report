create table attendance (
 sid varchar not null,
 pid varchar,
 name varchar,
 useragent varchar,
 etime TIMESTAMP WITH TIME ZONE,
 action varchar not null,
 role varchar not null,
 unique(sid,etime,action)
);

create view summary as
 with bymin as (
  select date_trunc('minute', etime at time zone 'Europe/Helsinki') as tsm,
   sum(case when action='Joined' then 1 else 0 end) as j,
   sum(case when action='Left' then -1 else 0 end) as l
  from attendance where role='Attendee' group by tsm)
  select tsm,
   sum(j+l) over (order by tsm rows unbounded preceding) ua,
   sum(j) over (order by tsm rows 0 preceding) uj,
   sum(l*-1) over (order by tsm rows 0 preceding) ul
  from bymin;

create view domains as
 select date_trunc('minute', etime at time zone 'Europe/Helsinki') as tsm,split_part(pid, '@', 2) as domain from attendance where role='Attendee' and action='Joined' order by tsm desc;

create view duration as
 SELECT sid, MIN(etime) AS start_time, MAX(etime) AS end_time, MAX(etime) - MIN(etime) AS duration FROM attendance where role='Attendee' GROUP BY sid order by duration;
