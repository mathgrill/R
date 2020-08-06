/*
select * from (
select * from public.colect limit 100) a
join
public.acs b
on a.caseid = b.caseid;
*/

--select max(workrvu), min(workrvu), avg(workrvu) from public.acs;

--limit 20;

--16.3535406381268576

select vyear, count(*) from public.colect group by vyear;