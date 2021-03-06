--select vyear, count(*) from public.colect group by vyear;

create table public.colect16_load (
CASEID numeric,
COL_STEROID varchar,
COL_STEROID_UNK numeric,
COL_MECH_BOWEL_PREP varchar,
COL_MECH_BOWEL_PREP_UNK numeric,
COL_ORAL_ANTIBIOTIC varchar,
COL_ORAL_ANTIBIOTIC_UNK numeric,
COL_CHEMO varchar,
COL_CHEMO_UNK numeric,
COL_INDICATION varchar,
COL_ICD9_INDICATION numeric,
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
