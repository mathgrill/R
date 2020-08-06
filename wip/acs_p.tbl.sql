--create unique index proct_caseid_key on public.proct(caseid);
/*
CREATE TABLE public.acs_p
AS
    SELECT x.*, p.*
      FROM public.acs x, public.proct p
     WHERE     p.caseid = x.caseid;
*/
	 
--select count(*) from public.proct;	 

--drop table public.acs_p;

  create table public.acs_p as  SELECT *
      FROM public.acs 
	  inner join public.proct  
       using(caseid);