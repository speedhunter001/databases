#QUESTION 1

#1. List the number of customers in each country. Only include countries with more than 10 customers.
SELECT Country, COUNT(Id) c
FROM CUSTOMER
GROUP BY Country
HAVING c > 10;

#2. List the number of customers in each country, except the USA, sorted high to low. Only include countries with 9 or more customers.
SELECT Country, COUNT(Id) c
FROM CUSTOMER
WHERE Country <> "USA"
GROUP BY Country
HAVING c > 9
ORDER BY c;

#3. List all CustomerId’s with average orders between $1000 and $1200.
SELECT Id, AVG(TotalAmount) 
FROM CUSTOMER 
INNER JOIN ORDER_ 
	ON CUSTOMER.Id = ORDER_.CustomerId #Because ORDER is keyword
GROUP BY Id;

#4. List the total number of customers from each city in each country (Consider the fact that two cities in different countries might have the same name)
SELECT Country, City, COUNT(Id) Total_Customers
FROM CUSTOMER
GROUP BY Country, City;

#5. List the sum of orders for each day in a particular week (e.g. sum of orders for each day (Monday to Friday) for the first week of December)
SELECT COUNT(Id)
FROM ORDER_
GROUP BY OrderDate
HAVING WEEK(OrderDate) = 9  #9 is supposed to be the first week of March 

#6. List the number of orders placed by each customer.
SELECT CUSTOMER.Id, COUNT(*) Total_Orders
FROM CUSTOMER
INNER JOIN ORDER_
	ON CUSTOMER.Id = ORDER_.CustomerId
GROUP BY Id;

#7. List the CustomerId of the most valued customer.
SELECT CUSTOMER.Id, COUNT(*) Total_Orders
FROM CUSTOMER
INNER JOIN ORDER_
	ON CUSTOMER.Id = ORDER_.CustomerId
GROUP BY Id
ORDER BY Total_Orders DESC LIMIT 1;   #Most valued is that customer who orders more

#8. List the CustomerId of the least valued customer.
SELECT CUSTOMER.Id, COUNT(*) Total_Orders
FROM CUSTOMER
INNER JOIN ORDER_
	ON CUSTOMER.Id = ORDER_.CustomerId
GROUP BY Id
ORDER BY Total_Orders LIMIT 1;

#9. List the date on which the company had the best sale.
SELECT OrderDate, SUM(TotalAmount) Total_Sale
FROM ORDER_
GROUP BY OrderDate
ORDER BY Total_Sale DESC LIMIT 1;



#QUESTION 2

#1. List the number of employees, total salary paid to employees that work in each department.
SELECT COUNT(*) AS total_employees, SUM(salary) AS total_salaries
FROM employee
GROUP BY dept_id;

#2. List the number of employees working in each department under each manager.
SELECT COUNT(*)
FROM employee
GROUP BY dept_id, manager_id;
	
#3. List the average salaries paid to each designation (job_id).
SELECT AVG(salary)
FROM employee
GROUP BY job_id;

#4. List the manager under whom the most number of employees are working.
SELECT COUNT(*) c, manager_id
FROM employee
GROUP BY manager_id
ORDER BY c DESC LIMIT 1;

#5. List the average salaries paid to each designation in each department.
SELECT AVG(salary)
FROM employee
GROUP BY job_id, dept_id;

#6. List the number of employees working under each manager in ascending order.
SELECT COUNT(*) c
FROM employee
GROUP BY manager_id
ORDER BY c;

#7. List the number of managers in each department.
SELECT COUNT(DISTINCT manager_id), 
FROM employee
GROUP BY dept_id;

#8. List the departments that has more than 3 employees.
SELECT dept_id
FROM employee
GROUP BY dept_id
HAVING COUNT(emp_id) > 3;

#9. List the department that has the most number of employees.
SELECT dept_id
FROM employee
GROUP BY dept_id
ORDER BY COUNT(*) DESC LIMIT 1;

#10. List the department that the least number of employees.
SELECT dept_id
FROM employee
GROUP BY dept_id
ORDER BY COUNT(*) LIMIT 1;



#QUESTION 3

#1. Get list of all the orders processed with a specific category name (you can use any category).
SELECT ShipCountry 
FROM Orders;

#2. Get the product name and count of orders processed for that product.
SELECT ProductName, c
FROM Products, (SELECT ProductID, COUNT(*) Total_Orders
				FROM Order_Details
				GROUP BY ProductID) AS Orders_per_product
WHERE Products.ProductID = Orders_per_product.ProductID

#3. Get the list of the employees who processed the orders belongs to his own city.
SELECT EmployeeID, LastName, FirstName
FROM Employees
NATURAL JOIN Orders
WHERE Employees.City = Orders.ShipCity

#4. Get the list of the employees who processed the orders doesn’t belongs to his own city.
SELECT EmployeeID, LastName, FirstName
FROM Employees
NATURAL JOIN Orders
WHERE Employees.City <> Orders.ShipCity

#5. Get the shipper company who processed the order categories “Seafood”.
SELECT Shippers.CategoryName
FROM Shippers, Orders, Products, Categories
WHERE Shippers.ShipperID = Orders.ShipVia
	AND Products.CategoryID = Categories.CategoryID
	AND Categories.CategoryName = "Seafood"

#6. Get category name, count of orders processed by the USA employees.
SELECT DISTINCT CategoryName, count(*)
FROM Categories c, Products p, Order_Details o_d, Orders o, Employees e
WHERE c.CategoryID = p.CategoryID
	AND o_d.ProductID = p.ProductID
	AND o_d.OrderID = o.OrderID
	AND o.EmployeeID = e.EmployeeID
GROUP BY e.City
HAVING e.City = "USA";

#7. For each order, calculate a subtotal for each Order.
SELECT OrderID, SUM(UnitPrice * Quantity * (1 - Discount)) AS subtotal
FROM Order_Details
GROUP BY OrderID;

#8. For each employee, get their sales amount.
SELECT EmployeeID, LastName, FirstName, SUM(UnitPrice * Quantity * (1 - Discount)) AS sales #assumption that sales is this 
FROM Employees e, Orders o, Order_Details o_d
WHERE e.EmployeeID = o.EmployeeID
	AND o_d.OrderID = o.OrderID
GROUP BY EmployeeID

#9. Get an alphabetical list of products along with the category and supplier of each product.
SELECT DISTINCT ProductID, ProductName, CategoryName, CompanyName
FROM Products p, Suppliers s, Categories c
WHERE p.SupplierID = s.SupplierID
	AND p.CategoryID = c.CategoryID
GROUP BY p.ProductID
ORDER BY ProductName

#10. Get the count of products in each category.
SELECT CategoryName, COUNT(ProductID)
FROM Products
NATURAL JOIN Categories
GROUP BY CategoryName




#QUESTION 4

#1. Show order id, customer name and order date for those orders in which Flagyl Syrup was sold.
SELECT order_id, customer_name, order_date 
FROM orders NATURAL JOIN order_detail 
			NATURAL JOIN products
WHERE p_name='Flagyl';

#2. Show complete order details (with information from products, orders and order_detail table) for the Customer Javed Iqbal.
SELECT *
FROM orders NATURAL JOIN order_detail 
			NATURAL JOIN products
WHERE customer_name='Javed Iqbal';

#3. Show the number of products for the supplier named Muneer Brothers.
SELECT COUNT(*) 
FROM suppliers 
INNER JOIN products ON suppliers.s_id=products.s_id 
GROUP BY s_name 
HAVING s_name='Munir Brothers';

#4. Delete the Avil syrup product from the product table.
DELETE FROM products 
WHERE p_name = 'Avil'

#5. Show products along with suppliers names for those suppliers that are in Peshawar.
SELECT DISTINCT p_name, s_name 
FROM products 
NATURAL JOIN suppliers 
WHERE city='Peshawar';

#6. Show the number of products Sanofi Aventis are supplying
SELECT COUNT(*)
FROM products NATURAL JOIN suppliers
WHERE s_name = 'Sanofi Aventis';



#QUESTION 5

#1. Show the customer’s last name, invoice number, invoice date and total amount for all customers.
SELECT CUS_LNAME, INV_NUMBER, INV_DATE, CUS_BALANCE
FROM CUSTOMER, INVOICE
WHERE CUSTOMER.CUS_CODE=INVOICE.CUS_CODE;

#2. Show the customer’s last name, invoice number, invoice date and total amount for those customers having purchased items.
SELECT DISTINCT CUS_LNAME, LINE.INV_NUMBER, INV_DATE, CUS_BALANCE
FROM CUSTOMER, INVOICE, LINE
WHERE CUSTOMER.CUS_CODE=INVOICE.CUS_CODE
	AND LINE.INV_NUMBER=INVOICE.INV_NUMBER;
	
#3
SELECT DISTINCT CUS_LNAME, I.INV_NUMBER, I.INV_DATE, P_DESCRIPT
FROM CUSTOMER C, INVOICE I, LINE L, PRODUCT P 
WHERE C.CUS_CODE = I.CUS_CODE
	AND I.INV_NUMBER = L.INV_NUMBER
	AND L.P_CODE = P.P_CODE;

#4
SELECT P_DESCRIPT, I.INV_NUMBER, INV_DATE
FROM INVOICE I, LINE L, PRODUCT P
WHERE I.INV_NUMBER = L.INV_NUMBER
	AND L.P_CODE = P.P_CODE;
