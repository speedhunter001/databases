#Question 1
#Write the SQL query to list the region names and the number of countries within the regions in the above database. 
SELECT region_name, COUNT(COUNTRY_NAME)
FROM regions
NATURAL JOIN countries
GROUP BY region_id;

#Write the SQL query to find all customers who have made orders before 2017. List must include the customer ID, customer name, and ordered by their ID values in descending. 
SELECT customer_id, name
FROM customers
NATURAL JOIN orders
WHERE YEAR(order_date) < 2017
ORDER BY customer_id DESC;

#Write the SQL query to list all customers who have the sequential letters ‘co’ in the customer name. List must include the customers’ ID, names and ordered by their names in ascending. 
SELECT customer_id, name
FROM customers
WHERE name LIKE '%co%'
ORDER BY names; 

#Write the SQL query to list all products’ ID, Name and price where the products haven’t been purchased by any customer in the database. The list must be ordered by the product price. 
SELECT product_id, product_name, list_price
FROM products
WHERE product_id NOT IN (SELECT product_id
						 FROM order_items);
ORDER BY list_price;						 

#Write the SQL query to list all the warehouses and their total sales. Here, given a product, the total sale of the product is calculated by the sold quantity of the product and its unit price. The list must be ordered by the total sales in the descending. [Reminder: one product_ID may link to more than one warehouses in the provided data. You can ignore this and just count the sale of the product to all its linked to warehouse. 
SELECT warehouse_id, warehouse_name, sales
FROM warehouses
NATURAL JOIN ( SELECT warehouse_id, product_id, sales 
               FROM inventories
               NATURAL JOIN ( SELECT DISTINCT(product_id), (unit_price * total_quantity) AS sales
							  FROM order_items
							  NATURAL JOIN ( SELECT product_id, SUM(quantity) AS total_quantity
			   				  				 FROM order_items
  			   				  				 GROUP BY product_id ) AS total_quantity_table ) AS sales_table ) AS inventories_sales_tables;

#Write the SQL query to list the employees and the quantity of orders that they proceeded in the database. The output list must include employee ID, name, and the quantity of orders. The list must be sorted by the quantity of orders in the descending order.
SELECT employee_id, COUNT(order_id)
FROM employees e
INNER JOIN orders o
ON e.employee_id = o.salesman_id
GROUP BY employee_id;

#Question 2
#Write a SQL query to list every customer and their purchased paintings. The list must be sorted by customer name first and painting title second. 
SELECT name, title AS purchased_painting
FROM customer_name
NATURAL JOIN purchase_details
ORDER BY name, purchased_painting;

#Write a SQL query to list the TOP-Three customers whose expenditure are the top-3 most in the database.
SELECT name, sales_price
FROM customer_name
NATURAL JOIN purchase_details
ORDER BY sales_price DESC LIMIT 3;
