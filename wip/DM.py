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
        cursor = connection.cursor()
        # Print PostgreSQL Connection properties
        # print ( connection.get_dsn_parameters(),"\n")
        # Print PostgreSQL version
        # sql = "SELECT version();"
        sql = """
    select t.*, 
    round(100*cnt2/NULLIF(sum(cnt2) OVER(),0),2) perc2,
    round(100*cnt3/NULLIF(sum(cnt3) OVER(),0),2) perc3
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
    def fn_out_tbl(x, i):
        f = open("D:/__DM__/outfile.html", "a")
        x = x.replace('<table border="1" class="dataframe">', '<table class="table table-sm table-bordered" id="table' + str(i) + '">')
        f.write(x)
        dv = '\n<div id="chart' + str(i) + '"></div>\n\n'
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
console.log(data1);
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