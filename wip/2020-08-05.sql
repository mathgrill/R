SELECT STRING_AGG( chr(39)||column_name||chr(39), ', ' order by ordinal_position)
  FROM information_schema.columns
 WHERE table_schema = 'public'
   AND table_name   = 'colect'
;

SELECT * 
  FROM information_schema.columns
 WHERE table_schema = 'public'
   AND table_name   = 'acs_p'
   --and data_type = 'numeric'
order by ordinal_position   
;
	
	
--select intervention, count(*) from public.vw_exp2 group by intervention; 	 
