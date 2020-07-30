--CREATE  INDEX idx_acs_cpt ON public.acs (cpt);
/*
create table public.acs_w as
select 
x.*
from 
public.acs x
where 
 pufyear between '2012' and '2018'
and (podiag in ('153.7', '153.2') OR podiag10 in ('C18.5', 'C18.6') )
and electsurg = 'Yes'
and cpt in ('44145','44207','44140','44204')
--limit 50
;
*/

drop view public.vw_exp1;

create or replace view public.vw_exp1 as
select
	--count(*)
	case when cpt in ('44145', '44207') then '2' when cpt in ('44140','44204') then '3' end as intervention,
	case when y.COL_NODESEVAL >= 12 then '12 or more' when y.COL_NODESEVAL>=0 then 'Less than 12' end as outcome,
	case when y.COL_NODESEVAL >= 12 then 'No' when y.COL_NODESEVAL>=0 then 'Yes' else 'NA' end as outcome_under12,
	optime as operative_time,
	case when COL_APPROACH is null then 'NA' when COL_APPROACH in (
'Hybrid w/ unplanned conversion to open',
					'Laparoscopic w/ unplanned conversion to Open',
					'Laparoscopic w/ unplanned conversion to open',
					'NOTES w/ unplanned conversion to open',
					'Other MIS approach w/ unplanned conversion to open',
					'Robotic w/ unplanned conversion to open',
					'SILS w/ unplanned conversion to open') then
				'Yes' else 'No' end as lap_converted_to_open,
	case 
/*when COL_ANASTOMOTIC in (
'Leak, no treatment intervention documented',
'Leak, treated w/ interventional means',
'Leak, treated w/ non-interventional/non-operative means',
'Leak, treated w/ reoperation') then 'Yes'*/ 
when COL_ANASTOMOTIC in (
'No',
'No definitive diagnosis of leak/leak related abscess') then  'No' 
when COL_ANASTOMOTIC = 'Unknown' then 'NA'
else 'Yes'
end as anastomotic_leak,
	OTHBLEED as Bleeding,
	case when OTHBLEED = 'No Complication' then 'No' else 'Yes' end as bleeding_b,
	case when SUPINFEC='Superficial Incisional SSI' or
		WNDINFD='Deep Incisional SSI' then
'Yes' else 'No' end as surgical_site_infection,
	ORGSPCSSI,
	case when ORGSPCSSI = 'No Complication' then 'No'
     when ORGSPCSSI is null then 'NA' else 'Yes' end as deep_organ_space_infection,
	DOpertoD,
	case when DOpertoD = '-99' then 'No' when DOpertoD is null then 'NA' else 'Yes' end as mortality,
	--mortality <- ifelse(!is.na(DOpertoD), ‘Yes’,’No’)
	TOTHLOS as Length_of_stay,
	REOPERATION1,
	READMISSION1,
	case when OTHSESHOCK is null then 'NA' when OTHSESHOCK = 'Septic Shock' then 'Yes' else 'No' end as Septic_shock,
	CDMI as myocardial_infarction,
	OPRENAFL as acute_renal_failure,
	case when OUPNEUMO is null then 'NA' when OUPNEUMO = 'Pneumonia' then 'Yes' else 'No' end as pneumonia,
	case when sex = 'male' then 'Yes' when sex is null then 'NA' else 'No' end as sex_male,
	race_new,
	case when race_new = 'White' then 'Yes' when race_new is null then 'NA'
when race_new in ('Unknown/Not Reported', 'Unknown') then 'NA' else 'No' end as race_new_white,
	coalesce(smoke, 'NA') as smoke,
	CNSCVA,
	case when CNSCVA is null then 'NA' when CNSCVA = 'No Complication' then 'No' else 'Yes' end as stroke,
	age,
	diabetes,
	asaclas,
	COL_MALIGNANCYT as pathologic_t_stage,
	COL_MALIGNANCYN as pathologic_n_stage,
	height, weight,
	703 * nullif (WEIGHT, -99)/(nullif(HEIGHT, -99)^2) as bmi
--x.*, y.*
from
	public.colect y,
	public.acs_w x
where 
y.caseid = x.caseid
	and pufyear between '2012' and '2018'
	and (podiag in ('153.7', '153.2') OR podiag10 in ('C18.5', 'C18.6') )
	and electsurg = 'Yes'
	and cpt in ('44145','44207','44140','44204')
order by DOpertoD desc
--limit 50
;
