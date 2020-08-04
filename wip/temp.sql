  SELECT intervention,
         SUM (CASE WHEN pro_numnodes IS NOT NULL THEN 1 ELSE 0 END)     AS cnt,
         ROUND (AVG (pro_numnodes), 6)                                  AS AVG,
         ROUND (STDDEV_POP (pro_numnodes), 6)                           AS stdev,
         'pro_numnodes'                                                 AS variable,
         SUM (CASE WHEN pro_numnodes IS NOT NULL THEN 0 ELSE 1 END)     AS cnt_na
    FROM (SELECT intervention, NULLIF (pro_numnodes, -99) AS pro_numnodes FROM public.vw_exp2
                                                                                             ) t
GROUP BY intervention
