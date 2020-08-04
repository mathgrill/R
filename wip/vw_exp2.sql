DROP VIEW public.vw_exp2;

CREATE VIEW public.vw_exp2
AS
    SELECT CASE WHEN pro_prelymph_n IN ('N2', 'N2a', 'N2b') THEN 'Yes' ELSE 'No' END
               AS intervention,
           CASE WHEN (pro_pathstage_t = 'T0' AND pro_pathlymph_n = 'N0') THEN 'Yes' ELSE 'No' END
               AS outcome,
           703 * NULLIF (weight, -99) / (NULLIF (height, -99) ^ 2)
               AS bmi,
           CASE
               WHEN pro_prestage_t IN ('T1', 'T2', 'T3') THEN pro_prestage_t
               WHEN pro_prestage_t IN ('T4', 'T4a', 'T4b') THEN 'T4 (any)'
               ELSE 'Other/Unk/NA'
           END
               AS pro_prestage_t_grouped,
           CASE
               WHEN pro_prelymph_n = 'N0'
               THEN
                   pro_prelymph_n
               WHEN pro_prelymph_n IN ('N1',
                                       'N1a',
                                       'N1b',
                                       'N1c')
               THEN
                   'N1 (any)'
               WHEN pro_prelymph_n IN ('N2', 'N2a', 'N2b')
               THEN
                   'N2 (any)'
               ELSE
                   'Other/Unk/NA'
           END
               AS pro_prelymph_n_grouped,
           CASE
               WHEN pro_predistantm_m IN ('M0/Mx') THEN pro_predistantm_m
               WHEN pro_predistantm_m IN ('M1', 'M1a', 'M1b') THEN 'M1 (any)'
               ELSE 'N/A'
           END
               AS pro_predistantm_m_grouped,
           CASE WHEN pro_chemo IN ('No', 'Yes') THEN pro_chemo ELSE 'Other/Unk/NA' END
               AS pro_chemo_grouped,
           CASE
               WHEN pro_approach IN ('Endoscopic w/ open assist', 'Open (planned)', 'Unknown')
               THEN
                   pro_approach
               WHEN pro_approach IN ('Hybrid',
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
                                     'SILS w/ unplanned conversion to open')
               THEN
                   'Hybrid, Lap, SILS, Other MIS'
               WHEN pro_approach IN ('NOTES', 'NOTES w/ open assist')
               THEN
                   'NOTES (all)'
               WHEN pro_approach IN ('Robotic', 'Robotic w/ open assist', 'Robotic w/ unplanned conversion to open')
               THEN
                   'Robotic'
           END
               AS pro_approach_grouped,
           CASE WHEN pro_pathstage_t IN ('T4', 'T4a', 'T4b') THEN 'T4 (any)' ELSE pro_pathstage_t END
               AS pro_pathstage_t_grouped,
           CASE
               WHEN pro_pathlymph_n IN ('N1',
                                        'N1a',
                                        'N1b',
                                        'N1c')
               THEN
                   'N1 (any)'
               WHEN pro_pathlymph_n IN ('N2', 'N2a', 'N2b')
               THEN
                   'N2 (any)'
               ELSE
                   pro_pathlymph_n
           END
               AS pro_pathlymph_n_grouped,
           CASE
               WHEN pro_pathdistantm_m IN ('M0/Mx', 'N/A', 'Unknown') THEN 'M0/Mx/Unk/NA'
               WHEN pro_pathdistantm_m IN ('M1', 'M1a', 'M1b') THEN 'M1 (any)'
           END
               AS pro_pathdistantm_m_grouped,
           CASE WHEN dopertod > 0 THEN 'Yes' ELSE 'No' END
               AS mortality,
           t.*
      FROM public.acs_p t
     WHERE     cpt IN ('45110',
                       '45111',
                       '44145',
                       '45395',
                       '45397',
                       '45119',
                       '45112')
           AND pro_prestage_t IN ('T2',
                                  'T3',
                                  'T4',
                                  'T4a',
                                  'T4b')
           AND pro_prelymph_n IN ('N0',
                                  'N1',
                                  'N1a',
                                  'N1b',
                                  'N1c',
                                  'N2',
                                  'N2a',
                                  'N2b')
           AND pro_radio = 'Yes';
