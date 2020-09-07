DROP view public.vw_exp5;

CREATE 
OR replace view public.vw_exp5 AS 
SELECT
   CASE
      WHEN
         FLOOR(random()*(2 - 1 + 1)) + 1 = 1 
      THEN
         'Yes' 
      ELSE
         'No' 
   END
   AS intervention, 
   CASE
      WHEN
         readmpodays1 >= 4 
         AND readmpodays1 <= 30 
      THEN
         'Yes' 
      WHEN
         readmpodays1 >= 0 
         AND readmpodays1 <= 3 
      THEN
         'YesB' 
      WHEN
         readmpodays1 = - 99 
      THEN
         'No' 
   END
   AS outcome, 
   CASE
      WHEN
         diabetes IN 
         (
            'DIABETES', 'NON-INSULIN', 'ORAL' 
         )
      THEN
         'Yes' 
      WHEN
         diabetes IN 
         (
            'NO' 
         )
      THEN
         'No' 
   END
   AS diabetes_bin, 
   CASE
      WHEN
         dyspnea IN 
         (
            'AT REST', 'MODERATE EXERTION' 
         )
      THEN
         'Yes' 
      WHEN
         dyspnea = 'No' 
      THEN
         'No' 
   END
   AS dyspnea_bin, 
   CASE
      WHEN
         dpralbum = - 99 
      THEN
         'No' 
      WHEN
         dpralbum != - 99 
      THEN
         'Yes' 
   END
   AS preop_albumin, 
   CASE
      WHEN
         dprcreat = - 99 
      THEN
         'No' 
      WHEN
         dprcreat != - 99 
      THEN
         'Yes' 
   END
   AS preop_creatinine, 
   CASE
      WHEN
         othbleed = 'Transfusions/Intraop/Postop' 
         OR othbleed = 'Bleeding/Transfusions' 
      THEN
         'Yes' 
      WHEN
         othbleed = 'No Complication' 
      THEN
         'No' 
   END
   AS transfusion, 
   CASE
      WHEN
         readmrelicd91 = '276.51' 
         OR readmrelicd101 = 'E86.0' 
      THEN
         'Yes' 
      WHEN
         NOT (readmrelicd91 = '276.51' 
         OR readmrelicd101 = 'E86.0') 
      THEN
         'No' 
   END
   AS dehydration, 
   CASE
      WHEN
         readmrelicd91 = '560.9' 
         OR readmrelicd101 = 'K56' 
         OR readmrelicd101 = 'K56.0' 
      THEN
         'Yes' 
      WHEN
         NOT (readmrelicd91 = '560.9' 
         OR readmrelicd101 = 'K56' 
         OR readmrelicd101 = 'K56.0') 
      THEN
         'No' 
   END
   AS bowel_obstruction, 
   CASE
      WHEN
         readmrelicd91 IN 
         (
            '338.18', '338.28' 
         )
         OR readmrelicd101 IN 
         (
            'G89.18', 'G89.28' 
         )
      THEN
         'Yes' 
      WHEN
         readmrelicd91 NOT IN 
         (
            '338.18', '338.28' 
         )
         AND readmrelicd101 NOT IN 
         (
            'G89.18', 'G89.28' 
         )
      THEN
         'No' 
   END
   AS complication_postop_pain, 
   CASE
      WHEN
         readmrelicd91 IN 
         (
            '292.0', '292.11', '292.12', '292.2', '292.81', '292.82', '292.83', '292.84', '292.85', '292.89', '292.9', '293.0', '293.1', '293.81', '293.82', '293.83', '293.84', '293.89', '293.9' 
         )
         OR readmrelicd101 IN 
         (
            'F19.939', 'F19.950', 'F19.951', 'F15.920', 'F19.921', 'F19.97', 'F19.96', 'F19.94', 'F11.182', 'F11.282', 'F11.982', 'F13.182', 'F13.282', 'F13.982', 'F14.182', 'F14.282', 'F14.982', 'F15.182', 'F15.282', 'F15.982', 'F19.182', 'F19.282', 'F19.982', 'F05', 'F06.2', 'F06.0', 'F06.1', 'F06.30', 'F06.4', 'F06.8', 'F53' 
         )
      THEN
         'Yes' 
      WHEN
         readmrelicd91 NOT IN 
         (
            '292.0', '292.11', '292.12', '292.2', '292.81', '292.82', '292.83', '292.84', '292.85', '292.89', '292.9', '293.0', '293.1', '293.81', '293.82', '293.83', '293.84', '293.89', '293.9' 
         )
         AND readmrelicd101 NOT IN 
         (
            'F19.939', 'F19.950', 'F19.951', 'F15.920', 'F19.921', 'F19.97', 'F19.96', 'F19.94', 'F11.182', 'F11.282', 'F11.982', 'F13.182', 'F13.282', 'F13.982', 'F14.182', 'F14.282', 'F14.982', 'F15.182', 'F15.282', 'F15.982', 'F19.182', 'F19.282', 'F19.982', 'F05', 'F06.2', 'F06.0', 'F06.1', 'F06.30', 'F06.4', 'F06.8', 'F53' 
         )
      THEN
         'No' 
   END
   AS complication_deliriumconfusion, 
   CASE
      WHEN
         readmrelicd91 IN 
         (
            '997.02', '349.1', '997.01', '997.09' 
         )
         OR readmrelicd101 IN 
         (
            'I97.811', 'I97.821', 'G97.81', 'G97.82' 
         )
      THEN
         'Yes' 
      WHEN
         readmrelicd91 NOT IN 
         (
            '997.02', '349.1', '997.01', '997.09' 
         )
         AND readmrelicd101 NOT IN 
         (
            'I97.811', 'I97.821', 'G97.81', 'G97.82' 
         )
      THEN
         'No' 
   END
   AS complication_neuro, 
   CASE
      WHEN
         readmrelicd91 IN 
         (
            '997.1', '997.1', '998.01', '429.4' 
         )
         OR readmrelicd101 IN 
         (
            'I9788', 'I9789', 'I97791', 'I97111', 'I97121', 'I97131', 'I97191', 'I9789' 
         )
      THEN
         'Yes' 
      WHEN
         readmrelicd91 NOT IN 
         (
            '997.1', '997.1', '998.01', '429.4' 
         )
         AND readmrelicd101 NOT IN 
         (
            'I9788', 'I9789', 'I97791', 'I97111', 'I97121', 'I97131', 'I97191', 'I9789' 
         )
      THEN
         'No' 
   END
   AS complication_cardiac, 
   CASE
      WHEN
         readmrelicd91 IN 
         (
            '518.51', '518.52', '518.53', '518.81', '518.82', '997.31', '997.32', '997.39', '518.4', '96.04', '96.70', '97.71', '97.72' 
         )
         OR readmrelicd101 IN 
         (
            'J95.1', 'J95.2', 'J95.3', 'J95.821', 'J95.822', 'J96.00', 'J96.20', 'J96.90', 'J80', 'J95.851', 'J95.89', 'J95.859', 'J95.88', 'J95.89', 'J81.0', '0BH17EZ', '0BH18EZ', '5A1935Z', '5A1945Z', '5A1955Z' 
         )
      THEN
         'Yes' 
      WHEN
         readmrelicd91 NOT IN 
         (
            '518.51', '518.52', '518.53', '518.81', '518.82', '997.31', '997.32', '997.39', '518.4', '96.04', '96.70', '97.71', '97.72' 
         )
         AND readmrelicd101 NOT IN 
         (
            'J95.1', 'J95.2', 'J95.3', 'J95.821', 'J95.822', 'J96.00', 'J96.20', 'J96.90', 'J80', 'J95.851', 'J95.89', 'J95.859', 'J95.88', 'J95.89', 'J81.0', '0BH17EZ', '0BH18EZ', '5A1935Z', '5A1945Z', '5A1955Z' 
         )
      THEN
         'No' 
   END
   AS complication_pulmonary, 
   CASE
      WHEN
         readmrelicd91 IN 
         (
            '536.2', '564.3', '96.07', '536.3', '560.1', '560.81', '560.89', '560.9' 
         )
         OR readmrelicd101 IN 
         (
            'K91.0', '0D9670Z', '0D9680Z', 'R11.10', 'K31.84', 'K56.0', 'K56.7', 'K56.5', 'K91.3', 'K56.69', 'K56.60' 
         )
      THEN
         'Yes' 
      WHEN
         readmrelicd91 NOT IN 
         (
            '536.2', '564.3', '96.07', '536.3', '560.1', '560.81', '560.89', '560.9' 
         )
         AND readmrelicd101 NOT IN 
         (
            'K91.0', '0D9670Z', '0D9680Z', 'R11.10', 'K31.84', 'K56.0', 'K56.7', 'K56.5', 'K91.3', 'K56.69', 'K56.60' 
         )
      THEN
         'No' 
   END
   AS complication_gastro, 
   CASE
      WHEN
         readmrelicd91 IN 
         (
            '276.51', '276.5', '584', '584.5', '584.6', '584.7', '584.8', '584.9', '586' 
         )
         OR readmrelicd101 IN 
         (
            'E86.0', 'E86.9', 'E904.2', 'N17.0', 'N17.1', 'N17.2', 'N17.8', 'N17.9', 'N19' 
         )
      THEN
         'Yes' 
      WHEN
         readmrelicd91 NOT IN 
         (
            '276.51', '276.5', '584', '584.5', '584.6', '584.7', '584.8', '584.9', '586' 
         )
         AND readmrelicd101 NOT IN 
         (
            'E86.0', 'E86.9', 'E904.2', 'N17.0', 'N17.1', 'N17.2', 'N17.8', 'N17.9', 'N19' 
         )
      THEN
         'No' 
   END
   AS complication_renal, 
   CASE
      WHEN
         readmrelicd91 IN 
         (
            '998.13', '998.30', '998.32', '998.6', '998.83' 
         )
         OR readmrelicd101 IN 
         (
            'T88.8XXA', 'T81.30XA', 'T81.31XA', 'T8183XA', 'T8183XD', 'T8183XS', 'T81.89XA' 
         )
      THEN
         'Yes' 
      WHEN
         readmrelicd91 NOT IN 
         (
            '998.13', '998.30', '998.32', '998.6', '998.83' 
         )
         AND readmrelicd101 NOT IN 
         (
            'T88.8XXA', 'T81.30XA', 'T81.31XA', 'T8183XA', 'T8183XD', 'T8183XS', 'T81.89XA' 
         )
      THEN
         'No' 
   END
   AS complication_wound, 
   CASE
      WHEN
         readmrelicd91 IN 
         (
            '998.31', '567.22', '569.81', '997.49' 
         )
         OR readmrelicd101 IN 
         (
            'T81.82XA', 'K65.1', 'K63.2', 'K91.3', 'K91.8', 'K91.81', 'K91.82', 'K91.83', 'K91.89' 
         )
      THEN
         'Yes' 
      WHEN
         readmrelicd91 NOT IN 
         (
            '998.31', '567.22', '569.81', '997.49' 
         )
         AND readmrelicd101 NOT IN 
         (
            'T81.82XA', 'K65.1', 'K63.2', 'K91.3', 'K91.8', 'K91.81', 'K91.82', 'K91.83', 'K91.89' 
         )
      THEN
         'No' 
   END
   AS complication_anastomoticleak, 
   CASE
      WHEN
         readmrelicd91 IN 
         (
            '998.1', '998.11', '568.81', '998.12' 
         )
         OR readmrelicd101 IN 
         (
            'K66.1', 'K91.61', 'K91.62', 'K91.840', 'K91.841', 'D78.01', 'D78.02', 'D78.21', 'D78.22', 'K76.01', 'L76.02', 'L76.21', 'L76.22', 'K91.61', 'K91.840' 
         )
      THEN
         'Yes' 
      WHEN
         readmrelicd91 NOT IN 
         (
            '998.1', '998.11', '568.81', '998.12' 
         )
         AND readmrelicd101 NOT IN 
         (
            'K66.1', 'K91.61', 'K91.62', 'K91.840', 'K91.841', 'D78.01', 'D78.02', 'D78.21', 'D78.22', 'K76.01', 'L76.02', 'L76.21', 'L76.22', 'K91.61', 'K91.840' 
         )
      THEN
         'No' 
   END
   AS complication_bleeding, 
   CASE
      WHEN
         readmrelicd91 IN 
         (
            '038.0', '038.1', '038.10', '038.11', '038.12', '038.19', '038.2', '038.3', '038.40', '038.41', '038.42', '038.43', '038.44', '038.49', '038.8', '038.9', '785.52', '785.59', '995.91', '995.92', '996.64', '998.00', '998.02', '998.09', '998.51', '682.9', '998.5', '998.59' 
         )
         OR readmrelicd101 IN 
         (
            'A40.9', 'A41.2', 'A41.01', 'A41.02', 'A41.1', 'A40.3', 'A41.4', 'A41.50', 'A41.3', 'A41.51', 'A41.52', 'A41.53', 'A41.59', 'A41.89', 'A41.9', 'R65.21', 'R57.1', 'R57.8', 'A41.9', 'R65.20', 'T83.51XA', 'T81.10XA', 'T81.12XA', 'T81.19XA', 'T81.4XXA', 'L03.90', 'L03.91', 'T814XXA', 'T814XXD', 'T814XXS', 'K68.11' 
         )
      THEN
         'Yes' 
      WHEN
         readmrelicd91 NOT IN 
         (
            '038.0', '038.1', '038.10', '038.11', '038.12', '038.19', '038.2', '038.3', '038.40', '038.41', '038.42', '038.43', '038.44', '038.49', '038.8', '038.9', '785.52', '785.59', '995.91', '995.92', '996.64', '998.00', '998.02', '998.09', '998.51', '682.9', '998.5', '998.59' 
         )
         AND readmrelicd101 NOT IN 
         (
            'A40.9', 'A41.2', 'A41.01', 'A41.02', 'A41.1', 'A40.3', 'A41.4', 'A41.50', 'A41.3', 'A41.51', 'A41.52', 'A41.53', 'A41.59', 'A41.89', 'A41.9', 'R65.21', 'R57.1', 'R57.8', 'A41.9', 'R65.20', 'T83.51XA', 'T81.10XA', 'T81.12XA', 'T81.19XA', 'T81.4XXA', 'L03.90', 'L03.91', 'T814XXA', 'T814XXD', 'T814XXS', 'K68.11' 
         )
      THEN
         'No' 
   END
   AS complication_infection, 
   CASE
      WHEN
         readmrelicd91 IN 
         (
            '451.81', '453.40', '453.41', '451.11', '451.19', '451.2', '453.42', '451.9', '453.8', '453.9', '415.11' 
         )
         OR readmrelicd101 IN 
         (
            'I82401', 'I82402', 'I82403', 'IB2409', 'I82411', 'I82411', 'I82412', 'I82413', 'I82419', 'I82421', 'I82422', 'I82423', 'I82429', 'I82431', 'I82432', 'I82433', 'I82439', 'I82442', 'I82443', 'I82449', 'I82491', 'I82492', 'I82493', 'I82499', 'I824Y1', 'I824Y2', 'I824Y3', 'I824Y9', 'I824Z1', 'I824Z2', 'I824Z3', 'I824Z9', 'I80.9', 'I82.91', 'I26.99' 
         )
      THEN
         'Yes' 
      WHEN
         readmrelicd91 NOT IN 
         (
            '451.81', '453.40', '453.41', '451.11', '451.19', '451.2', '453.42', '451.9', '453.8', '453.9', '415.11' 
         )
         AND readmrelicd101 NOT IN 
         (
            'I82401', 'I82402', 'I82403', 'IB2409', 'I82411', 'I82411', 'I82412', 'I82413', 'I82419', 'I82421', 'I82422', 'I82423', 'I82429', 'I82431', 'I82432', 'I82433', 'I82439', 'I82442', 'I82443', 'I82449', 'I82491', 'I82492', 'I82493', 'I82499', 'I824Y1', 'I824Y2', 'I824Y3', 'I824Y9', 'I824Z1', 'I824Z2', 'I824Z3', 'I824Z9', 'I80.9', 'I82.91', 'I26.99' 
         )
      THEN
         'No' 
   END
   AS complication_veinousthrombo, 
   CASE
      WHEN
         readmrelicd91 IN 
         (
            '54.12', '54.19', '54.25', '54.91', '450.3', '481', '54.61' 
         )
         OR readmrelicd101 IN 
         (
            '0WJG0ZZ', '3E1M38X', '3E1M38Z', '3E1H38X', '3E1H38Z', '3E1H88Z', '0W9G30Z', '0W9J30Z', '0D9N30Z', '0D9P30Z', '0WQFXZZ' 
         )
      THEN
         'Yes' 
      WHEN
         readmrelicd91 NOT IN 
         (
            '54.12', '54.19', '54.25', '54.91', '450.3', '481', '54.61' 
         )
         AND readmrelicd101 NOT IN 
         (
            '0WJG0ZZ', '3E1M38X', '3E1M38Z', '3E1H38X', '3E1H38Z', '3E1H88Z', '0W9G30Z', '0W9J30Z', '0D9N30Z', '0D9P30Z', '0WQFXZZ' 
         )
      THEN
         'No' 
   END
   AS complication_intervention_for_postop, replace(age, '+', ''):: NUMERIC AS age_num, t.* 
FROM
   public.acs t 
WHERE
   pufyear BETWEEN '2012' AND '2018' 
   AND readmpodays1 <= 30 
   AND emergncy = 'No' 
   AND cpt IN 
   (
      '44140', '44141', '44143', '44144', '44160', '44204', '44205', '44206', '44213', '44626', '44145', '44146', '44147', '44207', '44208', '45111', '45112', '45113', '45114', '45116', '45116', '45119', '45123', '45397', '44150', '44151', '44210', '44155', '44156', '44157', '44158', '44211', '44212', '45121', '45110', '45120', '45395' 
   )
   --LIMIT 5
;