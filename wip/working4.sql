select intervention, age, count(*) cnt from public.vw_exp1 
	group by intervention, age order by 1,2;
	
	--select * from public.analysis;
	
select intervention, avg(age), stddev_pop(age) 
from (
select intervention, replace(age,'+','')::numeric as age from public.vw_exp1 ) t
group by intervention;	
	
	select bmi, weight, height, intervention from public.vw_exp1 order by 1 nulls first;

select intervention, bmi::numeric, bmi from public.vw_exp1 where bmi is not null;
	
	--select intervention,replace(age,'+','')::numeric as age from public.vw_exp1;
select t.*, round(100*cnt/NULLIF(sum(cnt) OVER(partition by intervention),0),1) ratio_to_report from
(select intervention,race_new, count(*) cnt from public.vw_exp1 group by intervention,race_new ) t 
order by race_new, intervention;

select race_new, sum(case when intervention = '2' then 1 else 0 end) cnt2,
sum(case when intervention = '3' then 1 else 0 end) cnt3
from public.vw_exp1 group by race_new;

select t.*, 
round(100*cnt2/NULLIF(sum(cnt2) OVER(),0),1) ratio_to_report2,
round(100*cnt3/NULLIF(sum(cnt3) OVER(),0),1) ratio_to_report3
from
(select race_new, sum(case when intervention = '2' then 1 else 0 end) cnt2,
sum(case when intervention = '3' then 1 else 0 end) cnt3
from public.vw_exp1 group by race_new) t 
order by race_new;