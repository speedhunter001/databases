from py2neo import Graph
from flask import Flask, render_template, request, url_for, flash, redirect
from datetime import date, datetime
import time



# Defining two functions for use
def str_time_into_hour_minute_str(time_str):
    """This function takes time input as string for example 5:10 or 20:50
        and returns a tuple of its hour and minute for example (5,10) or (20,50)"""
    colon_index = time_str.find(':')
    
    hour = time_str[:colon_index]
    minutes = time_str[colon_index+1:]

    return (hour, minutes)

def str_time_into_unix_timestamp(time_str):
    """This function takes time input as string e.g, 5:10 and it calculates its unix timestamp according to the code
       and returns unix timestamp e.g, 15358540100 (dummy value)"""
    time_hour_str, time_minutes_str = str_time_into_hour_minute_str(time_str)

    # date_today = date.today()
    # date_with_time = datetime(date_today.year, date_today.month, date_today.day, int(time_hour_str), int(time_minutes_str))    
    date_with_time = datetime(2020, 3, 24, int(time_hour_str), int(time_minutes_str)) 

    return int( time.mktime(date_with_time.timetuple()) )



graph = Graph("bolt://localhost:7687", auth=("neo4j","speed150"))     # Connecting to Graph Database Neo4j.


f = Flask(__name__)

f.config['SECRET_KEY'] = 'a very very secret key'

@f.route('/')
def home():
    return render_template('home.html')

@f.route('/about')
def about():
    return render_template('about.html')

@f.route('/search', methods=["GET", "POST"])
def search():
    error = ""
    query = ""

    if request.method == "POST":
        attempted_celltowerno = request.form['celltowerno']
        attempted_starttime = request.form['starttime']
        attempted_endtime = request.form['endtime']

        if len(attempted_celltowerno)==0 or len(attempted_starttime)==0 or len(attempted_endtime)==0:
            error = "Please fill all the fields."

        else:  
            unix_start_time = str_time_into_unix_timestamp(attempted_starttime)
            unix_end_time = str_time_into_unix_timestamp(attempted_endtime)

            query = graph.run("""MATCH (ca:CALL)-[:LOCATED_IN]->(l:LOCATION) WHERE l.cell_tower = '{}' OR l.cell_tower = '{}' AND  {} < toInteger(ca.start) AND toInteger(ca.start) < {} WITH ca, l 
                                 MATCH (p:PERSON)-[:MADE_CALL]->(ca)-[:RECEIVED_CALL]->(d:PERSON) 
                                 RETURN p.full_name as caller, d.full_name as called, ca.start as time, ca.duration as duration, l.address as address""".format(attempted_celltowerno, str(int(attempted_celltowerno)+1), unix_start_time, unix_end_time))
    f = open('log.txt', 'w')
    f.write(str(query))
    return render_template('search.html', error=error, query_result=[ query.to_data_frame().to_html(classes='data', index=False) ], titles=query.to_data_frame().columns.values) # We pass the html of dataframe of result of query in a list so we can iterate over whole html in one go and in next parameter we pass columns in a list

@f.route('/support')
def support():
    return render_template('support.html')

if __name__ == '__main__':
    f.run(debug=True)
