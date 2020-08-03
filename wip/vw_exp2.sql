drop view public.vw_exp2;

create view public.vw_exp2 as
select 
case when PRO_PRELYMPH_N IN ('N2','N2a','N2b') then 'Yes'
else 'No' end as intervention,
case when (PRO_PATHSTAGE_T = 'T0' AND PRO_PATHLYMPH_N = 'N0') then 'Yes'
else 'No' end as outcome,
             703 * NULLIF (weight, -99) / (NULLIF (height, -99) ^ 2)
                 AS bmi,
case when PRO_PRESTAGE_T in ('T1', 'T2', 'T3') then PRO_PRESTAGE_T
when PRO_PRESTAGE_T in ('T4','T4a','T4b') then 'T4 (any)'
else 'Other/Unk/NA' end as
PRO_PRESTAGE_T_grouped,	
case when PRO_PRELYMPH_N = 'N0' then PRO_PRELYMPH_N
when PRO_PRELYMPH_N IN ('N1','N1a','N1b','N1c') then 'N1 (any)'
when PRO_PRELYMPH_N IN ('N2','N2a','N2b') then 'N2 (any)'
else 'Other/Unk/NA' end as
PRO_PRELYMPH_N_grouped,
case when PRO_PREDISTANTM_M in ('M0/Mx') then PRO_PREDISTANTM_M
when PRO_PREDISTANTM_M in ('M1','M1a','M1b') then 'M1 (any)'
else 'N/A' end as 
PRO_PREDISTANTM_M_grouped,
case when PRO_CHEMO in ('No', 'Yes') then PRO_CHEMO
else 'Other/Unk/NA' end as
PRO_CHEMO_grouped,
case when PRO_APPROACH in ('Endoscopic w/ open assist', 'Open (planned)', 'Unknown') then PRO_APPROACH
when PRO_APPROACH in ('Hybrid',
                                          'Hybrid w/ open assist',
                                          'Hybrid w/ unplanned conversion to open',
                                          'Laparoscopic',
                                          'Laparoscopic w/ open assist',
                                          'Laparoscopic w/ unplanned conversion to open',
                                          'Other',
                                          'Other MIS approach',
                                          'Other MIS approach w/ open assist',
                                          'Other MIS approach w/ unplanned conversion to open',
                                          'SILS',
                                          'SILS w/ open assist',
                                          'SILS w/ unplanned conversion to open'
) then 'Hybrid, Lap, SILS, Other MIS'
when PRO_APPROACH in ('NOTES','NOTES w/ open assist') then 'NOTES (all)'
when PRO_APPROACH in ('Robotic', 'Robotic w/ open assist',
'Robotic w/ unplanned conversion to open') then 'Robotic' end as
PRO_APPROACH_grouped,
case when PRO_PATHSTAGE_T IN ('T4','T4a','T4b') then 'T4 (any)'
else PRO_PATHSTAGE_T end as
PRO_PATHSTAGE_T_grouped,
case when PRO_PATHLYMPH_N in ('N1','N1a','N1b','N1c') then 'N1 (any)'
 when PRO_PATHLYMPH_N in ('N2','N2a','N2b') then 'N2 (any)'
else PRO_PATHLYMPH_N end as
PRO_PATHLYMPH_N_grouped,
case when PRO_PATHDISTANTM_M in ('M0/Mx','N/A','Unknown') then 'M0/Mx/Unk/NA'
when PRO_PATHDISTANTM_M in ('M1','M1a','M1b') then 'M1 (any)' end as
PRO_PATHDISTANTM_M_grouped,
case when dopertod > 0 then 'Yes' else 'No' end as 
mortality,
t.* from public.acs_p t
where 
cpt in ('45110','45111','44145','45395','45397','45119','45112')
and PRO_PRESTAGE_T in ('T2','T3','T4','T4a','T4b')
AND PRO_PRELYMPH_N in ('N0','N1','N1a','N1b','N1c','N2','N2a','N2b')
AND PRO_RADIO = 'Yes'
;





