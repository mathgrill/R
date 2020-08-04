select intervention, 
sum(case when pro_numnodes is not null then 1 else 0 end) as cnt, ROUND(avg(pro_numnodes), 6) as avg, 
ROUND(stddev_pop(pro_numnodes), 6) as stdev, 'pro_numnodes' as variable,
 sum(case when pro_numnodes is not null then 0 else 1 end) as cnt_na
from (
select intervention, nullif(pro_numnodes, -99) as pro_numnodes from public.vw_exp2 
--	where nullif(pro_numnodes, -99) is not null
) t
group by intervention
