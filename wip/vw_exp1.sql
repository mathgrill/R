-- View: public.vw_exp1

-- DROP VIEW public.vw_exp1;

CREATE OR REPLACE VIEW public.vw_exp1
 AS
 SELECT
        CASE
            WHEN x.cpt::text = ANY (ARRAY['44145'::character varying, '44207'::character varying]::text[]) THEN 'Yes'::text
            WHEN x.cpt::text = ANY (ARRAY['44140'::character varying, '44204'::character varying]::text[]) THEN 'No'::text
            ELSE NULL::text
        END AS intervention,
        CASE
            WHEN x.col_nodeseval >= 12::numeric THEN 'Yes'::text
            WHEN x.col_nodeseval >= 0::numeric THEN 'No'::text
            ELSE NULL::text
        END AS outcome,
        CASE
            WHEN x.col_nodeseval >= 12::numeric THEN 'No'::text
            WHEN x.col_nodeseval >= 0::numeric THEN 'Yes'::text
            ELSE 'NA'::text
        END AS outcome_under12,
    NULLIF(x.optime, '-99'::integer::numeric) AS operative_time,
        CASE
            WHEN x.col_approach IS NULL THEN 'NA'::text
            WHEN x.col_approach::text = ANY (ARRAY['Hybrid w/ unplanned conversion to open'::character varying, 'Laparoscopic w/ unplanned conversion to Open'::character varying, 'Laparoscopic w/ unplanned conversion to open'::character varying, 'NOTES w/ unplanned conversion to open'::character varying, 'Other MIS approach w/ unplanned conversion to open'::character varying, 'Robotic w/ unplanned conversion to open'::character varying, 'SILS w/ unplanned conversion to open'::character varying]::text[]) THEN 'Yes'::text
            ELSE 'No'::text
        END AS lap_converted_to_open,
    x.col_anastomotic,
        CASE
            WHEN x.col_anastomotic IS NULL THEN 'NA'::text
            WHEN x.col_anastomotic::text = ANY (ARRAY['No'::character varying, 'No definitive diagnosis of leak/leak related abscess'::character varying]::text[]) THEN 'No'::text
            WHEN x.col_anastomotic::text = 'Unknown'::text THEN 'NA'::text
            ELSE 'Yes'::text
        END AS anastomotic_leak,
    x.othbleed AS bleeding,
        CASE
            WHEN x.othbleed::text = 'No Complication'::text THEN 'No'::text
            ELSE 'Yes'::text
        END AS bleeding_b,
        CASE
            WHEN x.supinfec::text = 'Superficial Incisional SSI'::text OR x.wndinfd::text = 'Deep Incisional SSI'::text THEN 'Yes'::text
            ELSE 'No'::text
        END AS surgical_site_infection,
    x.orgspcssi,
        CASE
            WHEN x.orgspcssi::text = 'No Complication'::text THEN 'No'::text
            WHEN x.orgspcssi IS NULL THEN 'NA'::text
            ELSE 'Yes'::text
        END AS deep_organ_space_infection,
        CASE
            WHEN x.dopertod = '-99'::numeric THEN 'No'::text
            WHEN x.dopertod IS NULL THEN 'NA'::text
            ELSE 'Yes'::text
        END AS dopertod,
    NULLIF(x.tothlos, '-99'::integer::numeric) AS length_of_stay,
    x.reoperation1,
    x.readmission1,
        CASE
            WHEN x.othseshock IS NULL THEN 'NA'::text
            WHEN x.othseshock::text = 'Septic Shock'::text THEN 'Yes'::text
            ELSE 'No'::text
        END AS septic_shock,
    x.cdmi AS myocardial_infarction,
    x.oprenafl AS acute_renal_failure,
        CASE
            WHEN x.oupneumo IS NULL THEN 'NA'::text
            WHEN x.oupneumo::text = 'Pneumonia'::text THEN 'Yes'::text
            ELSE 'No'::text
        END AS pneumonia,
        CASE
            WHEN x.othdvt IS NULL THEN 'NA'::text
            WHEN x.othdvt::text = ANY (ARRAY['DVT Requiring Therap'::character varying, 'DVT Requiring Therapy'::character varying]::text[]) THEN 'Yes'::text
            ELSE 'No'::text
        END AS deep_vein_thrombosis,
    x.pulembol AS pulmonary_embolism,
        CASE
            WHEN x.sex::text = 'male'::text THEN 'Yes'::text
            WHEN x.sex IS NULL THEN 'NA'::text
            ELSE 'No'::text
        END AS sex_male,
    x.race_new,
        CASE
            WHEN x.race_new::text = 'White'::text THEN 'Yes'::text
            WHEN x.race_new IS NULL THEN 'NA'::text
            WHEN x.race_new::text = ANY (ARRAY['Unknown/Not Reported'::character varying, 'Unknown'::character varying]::text[]) THEN 'NA'::text
            ELSE 'No'::text
        END AS race_new_white,
    COALESCE(x.smoke, 'NA'::character varying) AS smoke,
    x.hypermed AS hypertension,
    x.cnscva,
        CASE
            WHEN x.cnscva IS NULL THEN 'NA'::text
            WHEN x.cnscva::text = 'No Complication'::text THEN 'No'::text
            ELSE 'Yes'::text
        END AS stroke,
    x.steroid,
    x.wtloss,
    x.bleeddis,
    x.hxchf,
    x.hxcopd,
    x.age AS age_orig,
    replace(x.age::text, '+'::text, ''::text)::numeric AS age,
    x.diabetes,
    x.asaclas,
    x.col_malignancyt AS pathologic_t_stage,
    x.col_malignancyn AS pathologic_n_stage,
    x.height,
    x.weight,
    703::numeric * NULLIF(x.weight, '-99'::integer::numeric) / (NULLIF(x.height, '-99'::integer::numeric) ^ 2::numeric) AS bmi
   FROM 
    acs_w x
  WHERE x.pufyear::text >= '2012'::text AND x.pufyear::text <= '2018'::text AND ((x.podiag::text = ANY (ARRAY['153.7'::character varying, '153.2'::character varying]::text[])) OR (x.podiag10::text = ANY (ARRAY['C18.5'::character varying, 'C18.6'::character varying]::text[]))) AND x.electsurg::text = 'Yes'::text AND (x.cpt::text = ANY (ARRAY['44145'::character varying, '44207'::character varying, '44140'::character varying, '44204'::character varying]::text[]))
  ORDER BY (
        CASE
            WHEN x.dopertod = '-99'::numeric THEN 'No'::text
            WHEN x.dopertod IS NULL THEN 'NA'::text
            ELSE 'Yes'::text
        END) DESC;

ALTER TABLE public.vw_exp1
    OWNER TO postgres;

