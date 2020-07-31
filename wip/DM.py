import psycopg2
import pandas as pd

class DM:

    @staticmethod
    def get_conn():
        connection = psycopg2.connect(user = "postgres",
                                    password = "pwd",
                                    host = "127.0.0.1",
                                    port = "5432",
                                    database = "postgres") 
        return connection        
    @staticmethod
    def pull_db(var):
        connection = DM.get_conn()         
        cursor = connection.cursor()
        # Print PostgreSQL Connection properties
        # print ( connection.get_dsn_parameters(),"\n")
        # Print PostgreSQL version
        # sql = "SELECT version();"
        sql = """
    select t.*, 
    round(100*cnt2/NULLIF(sum(cnt2) OVER(),0),1) ratio_to_report2,
    round(100*cnt3/NULLIF(sum(cnt3) OVER(),0),1) ratio_to_report3
    from
    (select race_new, sum(case when intervention = '2' then 1 else 0 end) cnt2,
    sum(case when intervention = '3' then 1 else 0 end) cnt3
    from public.vw_exp1 group by race_new) t 
    order by race_new 
        """
        sql = sql.replace('race_new', var)
        cr = connection.cursor()
        cr.execute(sql)
        tmp = cr.fetchall()

        # Extract the column names
        col_names = []
        for elt in cr.description:
            col_names.append(elt[0])

        # Create the dataframe, passing in the list of col_names extracted from the description
        dfv = pd.DataFrame(tmp, columns=col_names)    
        cr.close()
        #closing database connection.
        if(connection):
            # cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")
        return dfv  
                          
    @staticmethod
    def fn_out(x):
        f = open("D:/__DM__/outfile.html", "a")
        f.write(x)
        f.write("\n<br>\n")
        f.close()