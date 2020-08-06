--alter table public.colect alter column col_icd9_indication  type varchar;
--alter table public.colect alter column col_icd9_emergent  type varchar;

--alter table public.colect alter column col_margins  type varchar;
--CREATE UNIQUE INDEX colect_caseid_key ON public.colect (caseid);
--CREATE UNIQUE INDEX idx_colect_caseid ON public.acs (caseid);
select  vyear, count(*) from public.colect group by vyear;
/*
insert into public.colect 
(CASEID,
COL_STEROID,
COL_STEROID_UNK,
COL_MECH_BOWEL_PREP,
COL_MECH_BOWEL_PREP_UNK,
COL_ORAL_ANTIBIOTIC,
COL_ORAL_ANTIBIOTIC_UNK,
COL_CHEMO,
COL_CHEMO_UNK,
COL_INDICATION,
COL_ICD9_INDICATION,
COL_EMERGENT,
COL_ICD9_EMERGENT,
COL_APPROACH,
COL_MARGINS,
COL_MARGINS_UNK,
COL_MALIGNANCYT,
COL_MALIGNANCYN,
COL_MALIGNANCYM,
COL_ANASTOMOTIC,
COL_ILEUS,
COL_ILEUS_UNK,
--COL_NODESEVAL,
vyear)
select t.*, '2012' from public.colect12_load t;
*/
/*
create table public.colect12_load
(CASEID numeric,
COL_STEROID varchar,
COL_STEROID_UNK numeric,
COL_MECH_BOWEL_PREP varchar,
COL_MECH_BOWEL_PREP_UNK numeric,
COL_ORAL_ANTIBIOTIC varchar,
COL_ORAL_ANTIBIOTIC_UNK numeric,
COL_CHEMO varchar,
COL_CHEMO_UNK numeric,
COL_INDICATION varchar,
COL_ICD9_INDICATION varchar,
COL_EMERGENT varchar,
COL_ICD9_EMERGENT varchar,
COL_APPROACH varchar,
COL_MARGINS varchar,
COL_MARGINS_UNK numeric,
COL_MALIGNANCYT varchar,
COL_MALIGNANCYN varchar,
COL_MALIGNANCYM varchar,
COL_ANASTOMOTIC varchar,
COL_ILEUS varchar,
COL_ILEUS_UNK numeric);
*/
/*
create table public.colect13_load
(CASEID numeric,
COL_STEROID varchar,
COL_STEROID_UNK numeric,
COL_MECH_BOWEL_PREP varchar,
COL_MECH_BOWEL_PREP_UNK numeric,
COL_ORAL_ANTIBIOTIC varchar,
COL_ORAL_ANTIBIOTIC_UNK numeric,
COL_CHEMO varchar,
COL_CHEMO_UNK numeric,
COL_INDICATION varchar,
COL_ICD9_INDICATION varchar,
COL_EMERGENT varchar,
COL_ICD9_EMERGENT varchar,
COL_APPROACH varchar,
COL_MARGINS numeric,
COL_MARGINS_UNK numeric,
COL_MALIGNANCYT varchar,
COL_MALIGNANCYN varchar,
COL_MALIGNANCYM varchar,
COL_ANASTOMOTIC varchar,
COL_ILEUS varchar,
COL_ILEUS_UNK numeric);
*/
/*
create table public.colect14_load
(CASEID numeric,
COL_STEROID varchar,
COL_STEROID_UNK numeric,
COL_MECH_BOWEL_PREP varchar,
COL_MECH_BOWEL_PREP_UNK numeric,
COL_ORAL_ANTIBIOTIC varchar,
COL_ORAL_ANTIBIOTIC_UNK numeric,
COL_CHEMO varchar,
COL_CHEMO_UNK numeric,
COL_INDICATION varchar,
COL_ICD9_INDICATION varchar,
COL_EMERGENT varchar,
COL_ICD9_EMERGENT varchar,
COL_APPROACH varchar,
COL_MARGINS numeric,
COL_MARGINS_UNK numeric,
COL_MALIGNANCYT varchar,
COL_MALIGNANCYN varchar,
COL_MALIGNANCYM varchar,
COL_ANASTOMOTIC varchar,
COL_ILEUS varchar,
COL_ILEUS_UNK numeric,
COL_NODESEVAL numeric);
*/
--delete  from public.colect16_load; -- where vyear = '2016';

--select * from public.colect16_load;

--alter table public.colect16_load alter column col_icd9_indication  type varchar;

--alter table public.colect alter column col_icd9_emergent  type varchar;

--insert into public.colect select t.*, '2016' as vyear from public.colect16_load t;

--delete from public.colect where vyear is null;
/*
insert into public.colect 
(CASEID,
COL_STEROID,
COL_STEROID_UNK,
COL_MECH_BOWEL_PREP,
COL_MECH_BOWEL_PREP_UNK,
COL_ORAL_ANTIBIOTIC,
COL_ORAL_ANTIBIOTIC_UNK,
COL_CHEMO,
COL_CHEMO_UNK,
COL_INDICATION,
COL_ICD9_INDICATION,
COL_EMERGENT,
COL_ICD9_EMERGENT,
COL_APPROACH,
COL_MARGINS,
COL_MARGINS_UNK,
COL_MALIGNANCYT,
COL_MALIGNANCYN,
COL_MALIGNANCYM,
COL_ANASTOMOTIC,
COL_ILEUS,
COL_ILEUS_UNK,
--COL_NODESEVAL,
vyear)
select t.*, '2013' from public.colect13_load t;
*/
/*
insert into public.colect 
(CASEID,
COL_STEROID,
COL_STEROID_UNK,
COL_MECH_BOWEL_PREP,
COL_MECH_BOWEL_PREP_UNK,
COL_ORAL_ANTIBIOTIC,
COL_ORAL_ANTIBIOTIC_UNK,
COL_CHEMO,
COL_CHEMO_UNK,
COL_INDICATION,
COL_ICD9_INDICATION,
COL_EMERGENT,
COL_ICD9_EMERGENT,
COL_APPROACH,
COL_MARGINS,
COL_MARGINS_UNK,
COL_MALIGNANCYT,
COL_MALIGNANCYN,
COL_MALIGNANCYM,
COL_ANASTOMOTIC,
COL_ILEUS,
COL_ILEUS_UNK,
COL_NODESEVAL,
vyear)
select t.*, '2014' from public.colect14_load t;
*/
/*
create table public.colect15_load
(CASEID numeric,
COL_STEROID varchar,
COL_STEROID_UNK numeric,
COL_MECH_BOWEL_PREP varchar,
COL_MECH_BOWEL_PREP_UNK numeric,
COL_ORAL_ANTIBIOTIC varchar,
COL_ORAL_ANTIBIOTIC_UNK numeric,
COL_CHEMO varchar,
COL_CHEMO_UNK numeric,
COL_INDICATION varchar,
COL_ICD9_INDICATION varchar,
COL_EMERGENT varchar,
COL_ICD9_EMERGENT numeric,
COL_APPROACH varchar,
COL_MARGINS numeric,
COL_MARGINS_UNK numeric,
COL_MALIGNANCYT varchar,
COL_MALIGNANCYN varchar,
COL_MALIGNANCYM varchar,
COL_ANASTOMOTIC varchar,
COL_ILEUS varchar,
COL_ILEUS_UNK numeric,
COL_NODESEVAL numeric
);
*/