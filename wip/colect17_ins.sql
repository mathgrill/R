/*
select string_agg(col, concat(', ',chr(10) )) as cols from (
select column_name as col from information_schema.columns 
where table_name = 'colect' and table_schema = 'public' 
intersect
select column_name from information_schema.columns 
where table_name = 'colect17_load' and table_schema = 'public') a;
*/
insert into public.colect
(col_malignancyt, 
col_ileus_unk, 
col_oral_antibiotic, 
col_margins_unk, 
col_emergent, 
col_chemo_unk, 
caseid, 
col_icd9_indication, 
col_indication, 
col_anastomotic, 
col_malignancym, 
col_ileus, 
col_approach, 
col_chemo, 
col_mech_bowel_prep_unk, 
col_malignancyn, 
col_steroid_unk, 
col_nodeseval, 
col_icd9_emergent, 
col_margins, 
col_oral_antibiotic_unk, 
col_steroid, 
col_mech_bowel_prep,
vyear)
select 
col_malignancyt, 
col_ileus_unk, 
col_oral_antibiotic, 
col_margins_unk, 
col_emergent, 
col_chemo_unk, 
caseid, 
col_icd9_indication, 
col_indication, 
col_anastomotic, 
col_malignancym, 
col_ileus, 
col_approach, 
col_chemo, 
col_mech_bowel_prep_unk, 
col_malignancyn, 
col_steroid_unk, 
col_nodeseval, 
col_icd9_emergent, 
col_margins, 
col_oral_antibiotic_unk, 
col_steroid, 
col_mech_bowel_prep,
'2017' as vyear
from colect17_load;

--alter table public.colect add vyear varchar(4);

--update public.colect set vyear = '2018';

