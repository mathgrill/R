--drop view public.vw_exp1;

--select deep_organ_space_infection from public.vw_exp1 limit 10

--select intervention, coalesce(READMISSION1,'NA') var, count(*) cnt from public.vw_exp1 
--group by intervention, coalesce(READMISSION1,'NA')



SELECT *
FROM public.analysis;

select *
from pg_stat_activity;

SELECT *
FROM public.vw_exp1;

select intervention, stroke, count(*) cnt
from public.vw_exp1
group by intervention, stroke;

--select  coalesce(smoke,'NA') var, count(*) cnt from public.acs 
--group by coalesce(smoke,'NA')	

--select septic_shock, count(*) cnt from public.vw_exp1 group by septic_shock

select *
from public.vw_exp1 ;