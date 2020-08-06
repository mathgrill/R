SELECT *
  FROM information_schema.columns
 WHERE table_schema = 'public'
   AND table_name   = 'vw_exp2'
     ;
	
	
select intervention, count(*) from public.vw_exp2 group by intervention; 	 