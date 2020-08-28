DROP 
  TABLE public.exp4;
CREATE TABLE public.exp4 AS 
SELECT 
  CASE WHEN cpt IN ('44146', '44208') THEN 'Yes' WHEN cpt IN (
    '44140', '44145', '44204', '44207'
  ) THEN 'No' END AS intervention, 
  CASE WHEN orgspcssi = 'Organ/Space SSI' THEN 'Yes' WHEN orgspcssi = 'No Complication' THEN 'No' END AS outcome, 
  caseid, 
  703 * NULLIF (weight, -99) / (
    NULLIF (height, -99) ^ 2
  ) AS bmi, 
  CASE WHEN dopertod >= 0 THEN 'Yes' ELSE 'No' END AS mortality, 
  replace(age, '+', ''):: NUMERIC AS age, 
  sex, 
  race_new, 
  tothlos, 
  diabetes, 
  CASE WHEN diabetes = 'NO' THEN 'No' WHEN diabetes IS NULL THEN NULL ELSE 'Yes' END AS diabetes_bin, 
  smoke, 
  cdmi, 
  hxchf, 
  hxcopd, 
  ascites, 
  renainsf, 
  oprenafl, 
  steroid, 
  wtloss, 
  bleeddis, 
  othsysep, 
  asaclas, 
  dehis, 
  oupneumo, 
  reintub, 
  CASE WHEN othbleed IS NULL THEN 'NA' WHEN othbleed = 'No Complication' THEN othbleed ELSE 'Yes' END AS othbleed, 
  CASE WHEN othdvt IS NULL THEN 'NA' WHEN othdvt = 'No Complication' THEN othdvt ELSE 'Yes' END AS othdvt, 
  returnor, 
  supinfec, 
  wndinfd, 
  reoperation1, 
  podiag10, 
  wndclas, 
  emergncy, 
  cpt, 
  ventpatos, 
  optime, 
  CASE WHEN cpt IN ('44204', '44207', '44208') THEN 'MIS' WHEN cpt IN ('44140', '44145', '44146') THEN 'Open' END AS open_or_mis 
FROM 
  public.acs 
WHERE 
  (
    podiag10 = 'K57.20' 
    OR podiag = '562.11'
  ) 
  AND wndclas IN (
    '3-Contaminated', '4-Dirty/Infected'
  ) 
  AND emergncy = 'Yes' 
  AND cpt IN (
    '44140', '44145', '44204', '44207', 
    '44146', '44208'
  ) 
  AND COALESCE(othercpt1, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(othercpt2, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(othercpt3, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(othercpt4, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(othercpt5, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(othercpt6, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(othercpt7, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(othercpt8, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(othercpt9, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(othercpt10, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(concpt1, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(concpt2, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(concpt3, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(concpt4, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(concpt5, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(concpt6, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(concpt7, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(concpt8, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(concpt9, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(concpt10, 'x') NOT IN ('44143', '44206', '44141') 
  AND COALESCE(othseshock, 'x') != 'Septic Shock' 
  AND COALESCE(asaclas, 'x') != '5-Moribund' 
  AND COALESCE(ventpatos, 'x') NOT IN ('Yes');
