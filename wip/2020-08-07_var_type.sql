select col_mech_bowel_prep, count(*) from public.colect group by col_mech_bowel_prep;

select * from public.stats;

--select count(*) from public.colect;

insert into public.stats (table_name, column_name, val, cnt)
select 
'colect', 'col_mech_bowel_prep',
col_mech_bowel_prep, count(*) from public.colect group by col_mech_bowel_prep