/*1. non_usa_customers.sql: Provide a query showing Customers 
(just their full names, customer ID and country) who are not in the US.*/
SELECT FirstName, 
	   LastName, 
	   CustomerId,
	   Country
FROM Customer
WHERE Country <> 'USA';

/* 2. brazil_customers.sql: Provide a query only showing the Customers from Brazil.*/
SELECT FirstName, 
	   LastName, 
	   CustomerId,
	   Country
FROM Customer
WHERE Country = 'Brazil';

/*3.brazil_customers_invoices.sql: Provide a query showing the Invoices of 
customers who are from Brazil. The resultant table should show the customer's 
full name, Invoice ID, Date of the invoice and billing country.*/
SELECT c.FirstName,
	   c.LastName,
	   i.InvoiceId,
	   i.InvoiceDate,
	   i.BillingCountry
FROM Customer AS c
LEFT JOIN Invoice AS i on i.CustomerId = c.CustomerId
WHERE c.Country = 'Brazil';

/*4.sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.*/
SELECT * FROM Employee
WHERE Title like '%Sales%' AND Title like '%Agent%';

/*5.unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.*/
SELECT BillingCountry 
FROM Invoice
GROUP BY BillingCountry;

/*6.sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. 
The resultant table should include the Sales Agent's full name.*/
SELECT Employee.FirstName as 'Agent First Name',
		Employee.LastName as 'Agent Last Name',
		Invoice.InvoiceId,
		/*Invoice.CustomerId,
		Invoice.BillingAddress,
		Invoice.BillingCity,
		Invoice.BillingCountry,
		Invoice.BillingPostalCode,*/
		Invoice.Total
FROM Customer 
LEFT JOIN Employee on Employee.EmployeeId = Customer.SupportRepId
LEFT JOIN Invoice on Invoice.CustomerId = Customer.CustomerId;

/*7.invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name 
for all invoices and customers.*/
SELECT e.FirstName as "Agent First Name", 
		e.LastName as "Agent Last Name", 
		c.FirstName as "Customer First Name", 
		c.LastName as "Customer Last Name", 
		c.Country as "Customer Country" , 
		i.Total as "Invoice Total"
FROM Employee e, Customer c, Invoice i;

/*8.total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?*/
SELECT SUBSTRING(CONVERT(VARCHAR(10), InvoiceDate, 111), 0, 5) as 'Year',
COUNT(InvoiceId) as 'Invoice Count For Years 2009 and 2011'
FROM Invoice
WHERE InvoiceDate like '%2009%' OR InvoiceDate like '%2011%'
GROUP BY SUBSTRING(CONVERT(VARCHAR(10), InvoiceDate, 111), 0, 5) 


/*9.total_sales_{year}.sql: What are the respective total sales for each of those years?*/

SELECT SUM(Total) as 'Total Sales',
SUBSTRING(CONVERT(VARCHAR(10), InvoiceDate, 111), 0, 5) as 'Year'
FROM INVOICE
WHERE InvoiceDate like '%2009%' OR InvoiceDate like '%2011%'
GROUP BY SUBSTRING(CONVERT(VARCHAR(10), InvoiceDate, 111), 0, 5) 

/*10.invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs 
the number of line items for Invoice ID 37.*/
SELECT COUNT(InvoiceLineId) as 'Invoice Id #37 Line Item Count'
FROM InvoiceLine
WHERE InvoiceLine.InvoiceId = 37