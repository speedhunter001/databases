#1.Display the name of the employee who earns highest salary. 
SELECT first_name, last_name
FROM employees
WHERE salary = (SELECT MAX(salary) 
				FROM employees);

#2. Display the employee number and name for employee working as clerk and earning highest salary among clerks.
SELECT phone_number, first_name, last_name
FROM employees e
INNER JOIN (SELECT * 
               FROM jobs
               WHERE job_id LIKE '%CLERK') j 
WHERE e.job_id = j.job_id 
	AND e.salary = j.max_salary;

#3. Display the names of accountant who earns a salary more than the highest salary of any clerk
SELECT first_name, last_name
FROM employees 
WHERE job_id LIKE '%ACCOUNT'
	 AND salary > ANY (SELECT max_salary 
                       FROM jobs
                       WHERE job_id LIKE '%CLERK'); 

#4. Display the names of clerks who earn a salary more than the lowest salary of any programmer. 
SELECT first_name, last_name
FROM employees 
WHERE job_id LIKE '%CLERK'
	 AND salary > ANY (SELECT min_salary 
                       FROM jobs
                       WHERE job_id LIKE '%PROG'); 

#5. Display the names of employees who earn a salary more than that of Peter or that of salary greater than that of Lisa. 
SELECT first_name, last_name
FROM employees 
WHERE salary > ALL (SELECT salary 
                	FROM employees
                	WHERE first_name = 'Peter') #because there could be more than one person with first name Peter
      OR salary > ALL (SELECT salary 
                  	   FROM employees
                  	   WHERE first_name = 'Lisa'); #because there could be more than one person with first name Lisa

#6. Issue a query to list all the employees who salary is > the average salary of their own dept.
SELECT *
FROM employees e
INNER JOIN (SELECT department_id, AVG(salary) sal_per_department
            FROM employees
            GROUP BY department_id) sal_grpd
WHERE e.department_id = sal_grpd.department_id
	 AND e.salary > sal_grpd.sal_per_department;

#7. Display the names of the employees who earn highest salary in their respective departments.
SELECT first_name, last_name
FROM employees e
INNER JOIN (SELECT department_id, MAX(salary) max_salary 
			FROM employees 
			GROUP BY department_id) sal_grpd
WHERE e.department_id = sal_grpd.department_id
	 AND e.salary = sal_grpd.max_salary

#8. Write a query to display the name and job of all employees in dept 20 who have a job that someone in the Shipping dept as well 
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id = ANY ( SELECT job_id
				     FROM employees 
				     WHERE department_id = (SELECT department_id 
										    FROM departments
										    WHERE department_name = 'Shipping') )
      AND department_id = 20;

#9. Display the names of the employees who earn highest salaries in their respective job groups. 
SELECT first_name, last_name
FROM employees e
INNER JOIN (SELECT job_id, max_salary
            FROM jobs) j
WHERE e.job_id = j.job_id
	 AND e.salary = j.max_salary;

#10. Write a query to list the employees in dept 20 with the same job as anyone in dept 30.
SELECT *
FROM employees 	e1
INNER JOIN (SELECT *
            FROM employees
            WHERE department_id = 30) e2
WHERE e1.job_id = e2.job_id
     AND e1.department_id = 20;

#11. Display the employee names who are working in Finance department.
SELECT first_name, last_name
FROM employees
WHERE department_id = (SELECT department_id
					   FROM departments
					   WHERE department_name = 'Finance');

#12. List out the employee names who get the salary greater than the maximum salaries of dept with dept no 20, 30. 
SELECT first_name, last_name
FROM employees
WHERE salary > ANY (SELECT MAX(SALARY)
					FROM employees
					WHERE department_id = 20
	 					 OR department_id = 30
					GROUP BY department_id);

#13. Display the employee names who are working in Sydney.
SELECT first_name, last_name
FROM employees
WHERE department_id = ANY ( SELECT department_id
  							FROM departments
  							WHERE location_id = (SELECT location_id
                       		  					 FROM locations
                      		  					 WHERE city = 'Sydney') );

#14. Write a query to list the employees in dept 10 with the same job as anyone in the development dept.                      
SELECT *
FROM employees 	e1
INNER JOIN ( SELECT *
             FROM employees
             WHERE department_id = (SELECT department_id
                                    FROM departments
                                    WHERE department_name LIKE '%development%') ) e2
WHERE e1.job_id = e2.job_id
     AND e1.department_id = 10;

#15. Display the Job groups having total salary greater than the maximum salary for managers.
SELECT job_id, SUM(salary) total_salary
FROM employees
GROUP BY job_id
HAVING total_salary > ( SELECT MAX(salary)
                        FROM employees
                        WHERE employee_id IN (SELECT manager_id
                                              FROM departments) );

#16. Display the maximum salaries of the departments whose maximum salary is greater than 9000
SELECT department_id, MAX(salary) max_salary
FROM employees
GROUP BY department_id
HAVING department_id IS NOT NULL
      AND max_salary > 9000;                                              

#17. Display the names of employees from department number 10 with salary greater than that of any employee working in other department.            
SELECT first_name, last_name
FROM employees
WHERE department_id = 10
     AND salary > ANY( SELECT salary
                       FROM employees
                       WHERE department_id <> 10)

#18. Write a query to list the employees having the same job as employees working in ‘Munich’. 
SELECT e1.first_name, e2.last_name
FROM employees 	e1
INNER JOIN ( SELECT *
             FROM employees
             WHERE department_id = ( SELECT department_id 
                                     FROM departments
                                     WHERE location_id = (SELECT location_id
                                						  FROM locations
                               							  WHERE city = 'Munich') ) ) e2
            
WHERE e1.job_id = e2.job_id;

#19. Write a query that would display the employee name, job where each employee works and the name of their dept.                        
SELECT first_name, last_name, job_title, city, department_name
FROM (SELECT *
      FROM employees
      NATURAL JOIN jobs) e_j, (SELECT *
               			       FROM departments
               			       NATURAL JOIN locations) d_l
WHERE e_j.department_id = d_l.department_id		

#20. Display the employee(s) earning the second highest salary.		
SELECT *
FROM employees
WHERE salary = (SELECT salary
                FROM employees 
                ORDER BY salary DESC 
                LIMIT 1,1);				#show one row after skipping one row so second highest salary will retrn as result

#21. Display department names and employee count for those departments having no more than 2 employees.                
SELECT department_name, COUNT(*) total_employees
FROM employees
NATURAL JOIN departments
GROUP BY department_name
HAVING total_employees <= 2;