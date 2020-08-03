/*
CREATE INDEX idx_acs_cpt
    ON public.acs (cpt);


CREATE TABLE public.acs_w
AS
    SELECT x.*
      FROM public.acs x
     WHERE     pufyear BETWEEN '2012' AND '2018'
           AND (podiag IN ('153.7', '153.2') OR podiag10 IN ('C18.5', 'C18.6'))
           AND electsurg = 'Yes'
           AND cpt IN ('44145',
                       '44207',
                       '44140',
                       '44204')
--limit 50
;
*/

DROP VIEW public.vw_exp1;

CREATE OR REPLACE VIEW public.vw_exp1
AS
      SELECT                                                                                                  --count(*)
             CASE WHEN cpt IN ('44145', '44207') THEN '2' WHEN cpt IN ('44140', '44204') THEN '3' END
                 AS intervention,
             CASE WHEN y.col_nodeseval >= 12 THEN '12 or more' WHEN y.col_nodeseval >= 0 THEN 'Less than 12' END
                 AS outcome,
             CASE WHEN y.col_nodeseval >= 12 THEN 'No' WHEN y.col_nodeseval >= 0 THEN 'Yes' ELSE 'NA' END
                 AS outcome_under12,
             NULLIF(optime, -99)
                 AS operative_time,
             CASE
                 WHEN col_approach IS NULL
                 THEN
                     'NA'
                 WHEN col_approach IN ('Hybrid w/ unplanned conversion to open',
                                       'Laparoscopic w/ unplanned conversion to Open',
                                       'Laparoscopic w/ unplanned conversion to open',
                                       'NOTES w/ unplanned conversion to open',
                                       'Other MIS approach w/ unplanned conversion to open',
                                       'Robotic w/ unplanned conversion to open',
                                       'SILS w/ unplanned conversion to open')
                 THEN
                     'Yes'
                 ELSE
                     'No'
             END
                 AS lap_converted_to_open,
			 col_anastomotic,
             CASE
			     WHEN col_anastomotic IS NULL THEN 'NA'
                 WHEN col_anastomotic IN ('No', 'No definitive diagnosis of leak/leak related abscess') THEN 'No'
                 WHEN col_anastomotic = 'Unknown' THEN 'NA'
                 ELSE 'Yes'
             END
                 AS anastomotic_leak,
             othbleed
                 AS bleeding,
             CASE WHEN othbleed = 'No Complication' THEN 'No' ELSE 'Yes' END
                 AS bleeding_b,
             CASE
                 WHEN supinfec = 'Superficial Incisional SSI' OR wndinfd = 'Deep Incisional SSI' THEN 'Yes'
                 ELSE 'No'
             END
                 AS surgical_site_infection,
             orgspcssi,
             CASE WHEN orgspcssi = 'No Complication' THEN 'No' WHEN orgspcssi IS NULL THEN 'NA' ELSE 'Yes' END
                 AS deep_organ_space_infection,
             --dopertod,
             CASE WHEN dopertod = '-99' THEN 'No' WHEN dopertod IS NULL THEN 'NA' ELSE 'Yes' END
                 AS dopertod, --mortality	 
             --mortality <- ifelse(!is.na(DOpertoD), ‘Yes’,’No’)
             NULLIF(tothlos, -99)
                 AS length_of_stay,
             reoperation1,
             readmission1,
             CASE WHEN othseshock IS NULL THEN 'NA' WHEN othseshock = 'Septic Shock' THEN 'Yes' ELSE 'No' END
                 AS septic_shock,
             cdmi
                 AS myocardial_infarction,
             oprenafl
                 AS acute_renal_failure,
             CASE WHEN oupneumo IS NULL THEN 'NA' WHEN oupneumo = 'Pneumonia' THEN 'Yes' ELSE 'No' END
                 AS pneumonia, 
			 CASE WHEN othdvt IS NULL THEN 'NA' WHEN othdvt IN ('DVT Requiring Therap', 'DVT Requiring Therapy') THEN 'Yes'
			       ELSE 'No' END 
			     AS deep_vein_thrombosis,
			 pulembol as pulmonary_embolism,
             CASE WHEN sex = 'male' THEN 'Yes' WHEN sex IS NULL THEN 'NA' ELSE 'No' END
                 AS sex_male,
             race_new,
             CASE
                 WHEN race_new = 'White' THEN 'Yes'
                 WHEN race_new IS NULL THEN 'NA'
                 WHEN race_new IN ('Unknown/Not Reported', 'Unknown') THEN 'NA'
                 ELSE 'No'
             END
                 AS race_new_white,
             COALESCE (smoke, 'NA')
                 AS smoke,
			 hypermed as hypertension,
             cnscva,
             CASE WHEN cnscva IS NULL THEN 'NA' WHEN cnscva = 'No Complication' THEN 'No' ELSE 'Yes' END
                 AS stroke,
			 steroid, --steroid use
			 WTLOSS, -- >10% weight loss 
			 BLEEDDIS, --bleeding disorder
			 hxchf, --congestive heart failure 
			 hxcopd, --COPD
             age as age_orig,
			 replace(age,'+','')::numeric as age,
             diabetes,
             asaclas,
             col_malignancyt
                 AS pathologic_t_stage,
             col_malignancyn
                 AS pathologic_n_stage,
             height,
             weight,
             703 * NULLIF (weight, -99) / (NULLIF (height, -99) ^ 2)
                 AS bmi
        --x.*, y.*
        FROM public.colect y, public.acs_w x
       WHERE     y.caseid = x.caseid
             AND pufyear BETWEEN '2012' AND '2018'
             AND (podiag IN ('153.7', '153.2') OR podiag10 IN ('C18.5', 'C18.6'))
             AND electsurg = 'Yes'
             AND cpt IN ('44145',
                         '44207',
                         '44140',
                         '44204')
    ORDER BY dopertod DESC
;
