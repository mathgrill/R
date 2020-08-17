drop table public.exp4;

create table public.exp4 as
select 
case when CPT in ('44146','44208') then 'Yes'
 when  CPT in ('44140','44145','44204','44207') then 'No' end as intervention,
case when ORGSPCSSI = 'Organ/Space SSI'  then 'Yes'
 when ORGSPCSSI = 'No Complication' then 'No' end as outcome,
703 * NULLIF (weight, -99) / (NULLIF (height, -99) ^ 2) AS bmi,
CASE WHEN dopertod > 0 THEN 'Yes' ELSE 'No' END AS mortality,
replace(age,'+','')::numeric as age,
SEX,
RACE_NEW,
TOTHLOS,
DIABETES,
SMOKE,
CDMI,
HXCHF,
HXCOPD,
ASCITES,
RENAINSF,
OPRENAFL,
STEROID,
WTLOSS,
BLEEDDIS,
OTHSYSEP,
ASACLAS,
DEHIS,
OUPNEUMO,
REINTUB,
OTHBLEED,
OTHDVT,
RETURNOR,
SUPINFEC,
WNDINFD,
REOPERATION1,
--selection cols
PODIAG10,
WNDCLAS,
EMERGNCY,
CPT
from
public.acs
where (PODIAG10 = 'K57.20' OR PODIAG = '562.11')
and WNDCLAS in ('3-Contaminated', '4-Dirty/Infected')
and EMERGNCY='Yes'
and CPT in ('44140','44145','44204','44207', '44146','44208')
and COALESCE(OTHERCPT1, 'x') not in ('44143','44206','44141')
and COALESCE(OTHERCPT2, 'x') not in ('44143','44206','44141')
and COALESCE(OTHERCPT3, 'x') not in ('44143','44206','44141')
and COALESCE(OTHERCPT4, 'x') not in ('44143','44206','44141')
and COALESCE(OTHERCPT5, 'x') not in ('44143','44206','44141')
and COALESCE(OTHERCPT6, 'x') not in ('44143','44206','44141')
and COALESCE(OTHERCPT7, 'x') not in ('44143','44206','44141')
and COALESCE(OTHERCPT8, 'x') not in ('44143','44206','44141')
and COALESCE(OTHERCPT9, 'x') not in ('44143','44206','44141')
and COALESCE(OTHERCPT10, 'x') not in ('44143','44206','44141')
--
and COALESCE(CONCPT1, 'x')  not in ('44143','44206','44141')
and COALESCE(CONCPT2, 'x') not in ('44143','44206','44141')
and COALESCE(CONCPT3, 'x') not in ('44143','44206','44141')
and COALESCE(CONCPT4, 'x') not in ('44143','44206','44141')
and COALESCE(CONCPT5, 'x') not in ('44143','44206','44141')
and COALESCE(CONCPT6, 'x') not in ('44143','44206','44141')
and COALESCE(CONCPT7, 'x') not in ('44143','44206','44141')
and COALESCE(CONCPT8, 'x') not in ('44143','44206','44141')
and COALESCE(CONCPT9, 'x') not in ('44143','44206','44141')
and COALESCE(CONCPT10, 'x') not in ('44143','44206','44141')
and COALESCE(OTHSESHOCK, 'x') != 'Septic Shock'
and COALESCE(ASACLAS, 'x') != '5-Moribund'
;