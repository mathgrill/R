select distinct table_name, 
column_name from public.stats;

select column_name, count(*) from public.stats where table_name = 'acs_p'
group by column_name
order by 2 desc;

--select  "dprcreat" from public.acs_p order by "dprcreat" desc;

select * from (
select * from public.stats where table_name = 'acs_p') a
left join
(SELECT column_name, table_name, data_type,ordinal_position
  FROM information_schema.columns
 WHERE table_schema = 'public'
   AND table_name   = 'acs_p'
   --and data_type != 'numeric'
) b
   using (column_name, table_name)
   --where column_name IN ('pufyear', 'sex', 'race_new')
   order by ordinal_position, column_name, val