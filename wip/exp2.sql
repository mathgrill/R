create view public.vw_exp2 as
select 
case when PRO_PRELYMPH_N IN ('N2','N2a','N2b') then 'Yes'
else 'No' end as exposure,
case when (PRO_PATHSTAGE_T = 'T0' AND PRO_PATHLYMPH_N = 'N0') then 'Yes'
else 'No' end as outcome,
t.* from public.acs_p t
where 
cpt in ('45110','45111','44145','45395','45397','45119','45112')
and PRO_PRESTAGE_T in ('T2','T3','T4','T4a','T4b')
AND PRO_PRELYMPH_N in ('N0','N1','N1a','N1b','N1c','N2','N2a','N2b')
AND PRO_RADIO = 'Yes'
;





