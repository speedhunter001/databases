Project Title: Using Phone calls and Graphs to identify Suspects of a crime
Team:  p180030 Momina Atif Dar
 	   p180016 Muhammad Ammar Abid

Overview
The project uses power of Graph Database i.e Neo4j to load dummy data and then using graph traversal we can show people who were involved in any phone calls during/before/after a crime event at a given location using flask's frontend requiring cell phone tower number, start time and end time limit of a phone call.

Tools Used:
Graph Database (Neo4j)
Cypher Query Language
Flask
Html
Bootstrap

Files:
-The dummy-data-2.csv is the data used in database.
-neo4j-queries.txt is the file in which queries are written used to make node/relationships between nodes and the main query for traversal to identify suspects.One thing to keep in mind that the file was placed in var/lib/neo4j/imports folder so thats whats file:/// is for
-DB-Project folder has a main file app.py which is the python file of flask framework and connection with Graph Database.The html files are found in templates folder.The database connection is also made in local machine so localhost address/port may vary and the authentication stuff too.

How to Run:
Run  python app.py local  in terminal and go to the link mentioned.