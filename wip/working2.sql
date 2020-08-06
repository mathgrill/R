--select * from public.vw_exp1 where intervention = '2' and outcome = 'Less than 12';
--anastomotic_leak
--READMISSION1
--bleeding_b      bleeding	34 (6.8)	182 (7.1)	0.871	
--septic 4 (0.8)	31 (1.2)
--create table public.analysis as
select 
'READMISSION1' as variable,
t.*, 
round(100*t.cnt_a_y::decimal/(t.cnt_a_y+t.cnt_a_n+t.cnt_a_na),2) prc_a_y,
round(100*t.cnt_b_y::decimal/(t.cnt_b_y+t.cnt_b_n+t.cnt_b_na),2) prc_b_y,
round(100*t.cnt_a_n::decimal/(t.cnt_a_y+t.cnt_a_n+t.cnt_a_na),2) prc_a_n,
round(100*t.cnt_b_n::decimal/(t.cnt_b_y+t.cnt_b_n+t.cnt_b_na),2) prc_b_n,
round(100*t.cnt_a_na::decimal/(t.cnt_a_y+t.cnt_a_n+t.cnt_a_na),2) prc_a_na,
round(100*t.cnt_b_na::decimal/(t.cnt_b_y+t.cnt_b_n+t.cnt_b_na),2) prc_b_na
from (
with tb as (
select intervention, coalesce(READMISSION1,'NA') var, count(*) cnt from public.vw_exp1 
	group by intervention, coalesce(READMISSION1,'NA'))
select 
coalesce((select cnt  from tb where intervention ='2' and var = 'Yes') ,0) cnt_a_y,
coalesce((select cnt  from tb where intervention ='2' and var = 'No') ,0) cnt_a_n,
coalesce((select cnt  from tb where intervention ='2' and var = 'NA') ,0) cnt_a_na,
coalesce((select cnt  from tb where intervention ='3' and var = 'Yes') ,0) cnt_b_y,
coalesce((select cnt  from tb where intervention ='3' and var = 'No') ,0) cnt_b_n,
coalesce((select cnt  from tb where intervention ='3' and var = 'NA') ,0) cnt_b_na,
coalesce((select sum(cnt)  from tb where var = 'NA') ,0) cnt_na,
coalesce((select sum(cnt)  from tb) ,0) as cnt_all
) t;


--select intervention, mortality, count(*) from public.vw_exp1 group by intervention, mortality;

--select intervention, anastomotic_leak, count(*) from public.vw_exp1 group by intervention, anastomotic_leak order by 1,2,3;


select  intervention, anastomotic_leak, count(*) 
from public.vw_exp1 
group by intervention, anastomotic_leak
order by 1, 2;

select intervention, anastomotic_leak, col_anastomotic from public.vw_exp1 where anastomotic_leak = 'NA';
