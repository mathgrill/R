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
    def pull_db(var, my_data_view):
        connection = DM.get_conn()         
        # cursor = connection.cursor()
        # Print PostgreSQL Connection properties
        # print ( connection.get_dsn_parameters(),"\n")
        # Print PostgreSQL version
        # sql = "SELECT version();"
        sql = """
select t.*,
    round(100*"catA"/NULLIF(sum("catA") OVER(),0),2) "percA",
    round(100*"catB"/NULLIF(sum("catB") OVER(),0),2) "percB"
from
    (select coalesce(race_new, 'NA') as race_new, sum(case when intervention = 'Yes' then 1 else 0 end) "catA",
        sum(case when intervention = 'No' then 1 else 0 end) "catB"
    from my_data_view
    group by coalesce(race_new, 'NA')) t
order by case when race_new = 'Yes' then '1' 
              when race_new = 'No' then '2' 
              when race_new = 'NA' then 'ZZ' 
              when race_new = 'No Complication' THEN 'ZY' 
              when race_new = 'female' then 'Z' || race_new
              else race_new 
          end
        """
        sql = sql.replace('race_new', var).replace("my_data_view", my_data_view)
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
        dv = """
<div class="card-deck">
  <div class="card" style="min-width: 300px;">
    <div class="card-body">
      <div id="chart###" style="height:400px; width:500px;">
      </div>
    </div>
  </div>
  <div class="card" style="min-width: 300px;">
    <div class="card-body">
      <img src="img/img_heat_###.png" alt="..." class="card-img-top">
    </div>
  </div>
</div>       
        """
        dv = dv.replace("###", str(i))
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
    def db_num_var(var, my_data_view):
        connection = DM.get_conn() 
        sql = "select intervention, length_of_stay::numeric as my_var from my_data_view where nullif(length_of_stay, -99) is not null"
        sql = sql.replace('length_of_stay', var).replace('my_data_view', my_data_view)
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
    def db_num_var_stdev(var, my_data_view):
        connection = DM.get_conn() 
        sql = """
  SELECT intervention,
         SUM (CASE WHEN pro_numnodes IS NOT NULL THEN 1 ELSE 0 END)     AS cnt,
         ROUND (AVG (pro_numnodes), 6)                                  AS AVG,
         ROUND (STDDEV_POP (pro_numnodes), 6)                           AS stdev,
         'pro_numnodes'                                                 AS variable,
         SUM (CASE WHEN pro_numnodes IS NOT NULL THEN 0 ELSE 1 END)     AS cnt_na
    FROM (SELECT intervention, NULLIF (pro_numnodes, -99) AS pro_numnodes FROM my_data_view
                                                                                             ) t
GROUP BY intervention 
ORDER BY intervention DESC
"""
        sql = sql.replace('pro_numnodes', var).replace('my_data_view', my_data_view)
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

    @staticmethod
    def fn_var_header(var, i):
        hd = '<h3 id="my-var-' + str(i) + '">' + str(i) + '. ' + var + '</h3>'
        nav = """
    <div class="btn-group" role="group" aria-label="Basic example">
        <a class="btn btn-light" href="#my-var-PREV">&#9665;</a>
        <a class="btn btn-light" href="#my-var-THIS">&#9673;</a>
        <a class="btn btn-light" href="#my-var-NEXT">&#9655;</a>
    </div>  
    """
        nav = nav.replace('PREV', str(i - 1))
        nav = nav.replace('THIS', str(i))
        nav = nav.replace('NEXT', str(i + 1))
        hd = hd + nav   
        return hd   

    @staticmethod
    def fetch_df(sql):
        connection = DM.get_conn()         
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
    def run_stmt(sql):
        connection = DM.get_conn()         
        cr = connection.cursor()
        cr.execute(sql)
        connection.commit()
        cr.close()
        #closing database connection.
        if(connection):
            # cursor.close()
            connection.close()

    @staticmethod
    def perc_heat(df):
        dfh = df.iloc[:,[0,3,4]].copy(deep=True)
        cols = dfh.columns
        dfh[cols[1]] = dfh[cols[1]].astype(float)
        dfh[cols[2]] = dfh[cols[2]].astype(float)       
        dfh.set_index(cols[0], inplace=True)
        return dfh