USE themepark;

#1. Write a query which lists the names and dates of births of all employees born on the 14th day of the month.
SELECT EMP_FNAME, EMP_LNAME, EMP_DOB 
FROM EMPLOYEE 
WHERE DAY(EMP_DOB) = 14;

#2. Write a query which lists the approximate age of the employees on the company’s tenth anniversary date (11/25/2008).
SELECT TIMESTAMPDIFF(year, EMP_DOB, '2008-11-25') 
	  AS AGE_ON_ANNIVERSARY 
FROM EMPLOYEE;

#3. Write a query which generates a list of employee user passwords, using the first three digits of their phone number, and the first two characters of first name in lower case.Label the column USER_PASSWORD;
SELECT CONCAT( SUBSTR(EMP_PHONE,1,3), LOWER( SUBSTR(EMP_FNAME,1,2) ) ) 
	  AS USER_PASSWORD 
FROM EMPLOYEE;

#4. Write a query which displays the last date a ticket was purchased in all Theme Parks.You should also display the Theme Park name. Print the date in the format 12th January 2007.
SELECT PARK_NAME, DATE_FORMAT( MAX(SALE_DATE),'%D %b %Y' ) 
FROM SALES 
NATURAL JOIN THEMEPARK
GROUP BY PARK_CODE;

#5. Using the date specifiers in Table 7.2, modify the query shown in Figure 55 to display the date in the format ’Fri – 18 – 5 – 07’.
SELECT DISTINCT( DATE_FORMAT(SALE_DATE, '%a-%e-%c-%y') ) 
FROM SALES;

#You can use any already define database for the demonstration of TCL 

#o Disable the autocommit option as shown in log file
SET AUTOCOMMIT=0;

#o Inset some data in any table, update some data in any table
INSERT INTO SALES VALUE(1277, 'FR1001', '2020-08-08');

SELECT * 
FROM SALES;

#o Now apply rollback and see the result
ROLLBACK;

#o Do some more transactions of insert, update and delete. Afterwards add a savepoint 
INSERT INTO SALES VALUE(1279, 'FR1001', '2020-08-08');

UPDATE SALES
SET PARK_CODE='ZA1342'
WHERE TRANSACTION_NO=1277; 

DELETE FROM SALES
WHERE TRANSACTION_NO=1277;

SAVEPOINT savepnt;

SELECT * 
FROM SALES;
#o Insert 2 to 3 rows and then go back to previous savepoint and see the results.
INSERT INTO SALES VALUE(1230, 'FR1001', '2020-08-08');
INSERT INTO SALES VALUE(1232, 'ZA1342', '2020-08-08');

SELECT * 
FROM SALES;

ROLLBACK TO savepnt;

SELECT * 
FROM SALES;