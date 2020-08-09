create view public.vw_exp3 as
select smoke as intervention, HXCOPD as outcome,
SEX,
RACE_NEW,
SURGSPEC,
ELECTSURG,
703 * NULLIF (weight, -99) / (NULLIF (height, -99) ^ 2) AS bmi,
DIABETES,
DYSPNEA,
VENTILAT,               
CDMI,                 
CNSCVA,                   
ASCITES,
HYPERMED,
RENAFAIL,
DIALYSIS,
DISCANCR,
WNDINF,
STEROID,
WTLOSS,
BLEEDDIS,
TRANSFUS,
PRSEPIS,
ASACLAS,
SUPINFEC,
WNDINFD,
ORGSPCSSI,
DEHIS,
OUPNEUMO,
REINTUB,
PULEMBOL,
RENAINSF,
OPRENAFL,
URNINFEC,
CDARREST,
OTHBLEED,
OTHDVT,
OTHSYSEP,
OTHSESHOCK,
WOUND_CLOSURE,
OTHCDIFF,
           CASE WHEN dopertod > 0 THEN 'Yes' ELSE 'No' END
               AS mortality
from public.acs limit 1000;


/*
a)	Population:
all

b)	Exposure (treatment):
SMOKE = Yes
SMOKE = No

c)	Outcome: 

HXCOPD=Yes
HXCOPD=No


d)	Co-variates:

SEX
*/
