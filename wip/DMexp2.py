import psycopg2
import pandas as pd

class DM:

    @staticmethod
    def get_conn():
        connection = psycopg2.connect(user = "postgres",
                                    password = "boom1234",
                                    host = "127.0.0.1",
                                    port = "5432",
                                    database = "postgres") 
        return connection  

    @staticmethod
    def pull_db(var):
        connection = DM.get_conn()         
        # cursor = connection.cursor()
        # Print PostgreSQL Connection properties
        # print ( connection.get_dsn_parameters(),"\n")
        # Print PostgreSQL version
        # sql = "SELECT version();"
        sql = """
select t.*,
    round(100*cnt2/NULLIF(sum(cnt2) OVER(),0),2) perc2,
    round(100*cnt3/NULLIF(sum(cnt3) OVER(),0),2) perc3
from
    (select coalesce(race_new, 'NA') as race_new, sum(case when intervention = 'Yes' then 1 else 0 end) cnt2,
        sum(case when intervention = 'No' then 1 else 0 end) cnt3
    from public.vw_exp2
    group by coalesce(race_new, 'NA')) t
order by case when race_new = 'Yes' then '1' when race_new = 'No' then '2' when
	race_new = 'NA' then 'ZZ' when race_new = 'No Complication' THEN 'ZY' else race_new end
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
            # print("PostgreSQL connection is closed")
        return dfv  
                          
    @staticmethod
    def fn_out_tbl(x, i):
        f = open("D:/__DM__/outfile.html", "a")
        x = x.replace('<table border="1" class="dataframe">', '<table class="table table-sm table-bordered cstats" id="table' + str(i) + '">')
        f.write(x)
        dv = '\n<div id="chart' + str(i) + '" style="height:400px;"></div>\n\n'
        f.write(dv)
        scr = """
<script>
var x1 = $('#table1 td:nth-child(2)').map(function(){
   return $(this).text();
}).get();
var data1 = $('#table1 td:nth-child(3)').map(function(){
   return $(this).text();
}).get();
var data2 = $('#table1 td:nth-child(4)').map(function(){
   return $(this).text();
}).get();
// console.log(data1);
var trace1 = {
  x: x1,
  y: data1,
  name: 'Int 2',
  type: 'bar',
  text: data1.map(String),
  textposition: 'auto'  
};
var trace2 = {
  x: x1,
  y: data2,
  name: 'Int 3',
  type: 'bar',
  text: data2.map(String),
  textposition: 'auto'  
};
var data = [trace1, trace2];
var layout = {barmode: 'group'}; //stack
Plotly.newPlot('chart1', data, layout);
</script>
        """
        scr = scr.replace('table1', 'table' + str(i))
        scr = scr.replace('chart1', 'chart' + str(i))
        f.write(scr)
        f.write("\n\n")
        f.close()

    @staticmethod
    def fn_out(x):
        f = open("D:/__DM__/outfile.html", "a")
        x = x.replace('<table border="1" class="dataframe">', '<table class="table table-sm table-bordered">')
        f.write(x)
        # f.write("\n<br>\n")
        f.close() 

    @staticmethod
    def db_var_desc(var):
        connection = DM.get_conn()         
        #cursor = connection.cursor()
        sql = "select * from public.nsqip_variable_list where lower (variable) = %(some_id)s order by options"
        cr = connection.cursor()
        cr.execute(sql, {'some_id': var})
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
            # print("PostgreSQL connection is closed")
        return dfv      

    @staticmethod
    def fn_out_tbl_simple(x):
        x = x.to_html()
        f = open("D:/__DM__/outfile.html", "a")
        x = x.replace('<table border="1" class="dataframe">', '<table style="width: auto;" class="table table-sm table-dark c-defs">')
        f.write(x)
        f.write("\n\n")
        f.close() 

    @staticmethod
    def fn_out_tbl_num(x, i):
        x = x.to_html()
        f = open("D:/__DM__/outfile.html", "a")
        x = x.replace('<table border="1" class="dataframe">', '<table style="width: auto;" class="table table-sm table-dark c-defs" id="table' + str(i) + '">')
        f.write(x)
        f.write("\n\n")
        f.close()                           

    @staticmethod
    def db_num_var(var):
        connection = DM.get_conn() 
        sql = "select intervention, length_of_stay::numeric as my_var from public.vw_exp2 where nullif(length_of_stay, -99) is not null"
        sql = sql.replace('length_of_stay', var)
        cr = connection.cursor()
        cr.execute(sql)
        tmp = cr.fetchall()
        # Extract the column names
        col_names = []
        for elt in cr.description:
            col_names.append(elt[0])
        # Create the dataframe, passing in the list of col_names extracted from the description
        df = pd.DataFrame(tmp, columns=col_names) 
        cr.close()
        if(connection):
            connection.close()
            #print("PostgreSQL connection is closed")   
        return df     

    @staticmethod
    def db_num_var_stdev(var):
        connection = DM.get_conn() 
        sql = """
select intervention, count(*) as cnt, ROUND(avg(length_of_stay), 6) as avg, ROUND(stddev_pop(length_of_stay), 6) as stdev, 'length_of_stay' as variable 
from (
select intervention, length_of_stay from public.vw_exp2 where nullif(length_of_stay, -99) is not null ) t
group by intervention
"""
        sql = sql.replace('length_of_stay', var)
        cr = connection.cursor()
        cr.execute(sql)
        tmp = cr.fetchall()
        # Extract the column names
        col_names = []
        for elt in cr.description:
            col_names.append(elt[0])
        # Create the dataframe, passing in the list of col_names extracted from the description
        df = pd.DataFrame(tmp, columns=col_names) 
        cr.close()
        if(connection):
            connection.close()
            #print("PostgreSQL connection is closed")   
        return df   

    @staticmethod
    def fn_out_add_html(x):
        f = open("D:/__DM__/outfile.html", "a")
        f.write(x)
        f.write("\n\n")
        f.close()              