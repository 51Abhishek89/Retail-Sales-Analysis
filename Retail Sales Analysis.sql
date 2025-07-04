select * from retail_sales;

select distinct category from retail_sales;

-- Data Cleaning 
select * from retail_sales
where transactions_id is NULL;

select * from retail_sales
where sale_date is NULL;

select * from retail_sales
where sale_time is NULL;

select * from retail_sales 
where 
	transactions_id is NULL
	or
	sale_date is NULL
	or 
	sale_time is NULL
	or 
	customer_id is NULL
	or 
	gender is NULL
	or 
	age is NULL
	or 
	category is NULL
	or 
	quantiy is NULL
	or
	price_per_unit is NULL
	or
	cogs is NULL
	or 
	total_sale is NULL;

-- Deleting the Columns with null values ---

Delete from retail_sales h
where 
	transactions_id is NULL
	or
	sale_date is NULL
	or 
	sale_time is NULL
	or 
	customer_id is NULL
	or 
	gender is NULL
	or 
	age is NULL
	or 
	category is NULL
	or 
	quantiy is NULL
	or
	price_per_unit is NULL
	or
	cogs is NULL
	or 
	total_sale is NULL;


-- Data Exploration 

-- How many sales we have?
select count(*) as total_sale from retail_sales;

-- How many Customers do we have?
select count(customer_id) as Cs from retail_sales;

-- How many Unique customers do we have?
select count(distinct customer_id) as UniqueCs from retail_sales;

-- How many unique and total category do we have?
select count(distinct category) as ctg from retail_sales;
select count (category) as ctg from retail_sales;

 -- Data Analysis and Business Key Problems & Answers

 -- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'

 select * from retail_sales where sale_date = '2022-11-05'; 


-- Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4
-- in the month of Nov 2022


select * from retail_sales 
where category = 'Clothing'
	  AND
	  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	  AND 
	  quantiy <= 4;


-- Q3. Write a query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) as net_sale, count(*) as total_orders
from retail_sales group by 1;


-- Q4. Write a SQL query to find the average age of customers who purchased the items from 'Beauty' category.

Select Round( Avg(age), 1) as avg_age from retail_sales where category = 'Beauty';


-- Q5. Write a SQL query to find all the transactions where the total_sale is greater than 1000.

select customer_id, gender, age, category, total_sale from retail_sales 
where total_sale > '1000';


-- Q6. Write a SQL query to find the total number of transactions(transactions_id) made by each gender in each category.

select category, gender, count(*) as total_transaction 
from retail_sales group by category, gender Order by 1;


-- Q7. Write a SQL query to calculate the average sale for each month. Find out	best selling month in each year.

select year, month, avg_sale
from(
select
	Extract(YEAR from sale_date) as year,
	Extract(MONTH from sale_date) as month,
	AVG(total_sale) as avg_sale,
	Rank() over (partition by extract(Year from sale_date) order by Avg(total_sale) DESC) as rank
from retail_sales
group by 1, 2) as T1 where rank = 1;



-- Q8. Write a SQL query to find the top 5 customers

select customer_id, sum(total_sale) as total_sales
from retail_sales
group by 1 
order by 2 desc
limit 5;

-- Q9. Write a SQL query to find the number of unique cusotmers who purchased items for each category.

select category, count(distinct customer_id) as cnt_unique_cs
from retail_sales group by category;


-- Q10. Write a SQL query to create each shift and number to orders (Example Morning <= 12, Afternoon between 12 and 17, Evening > 17)

With hourly_sale
AS
(
Select *, 
	case 
		WHEN EXTRACT(HOUR FROM sale_date) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_date) BETWEEN 12 and 17 THEN'Afternoon'
		Else 'Evening'
	END as shift
FROM retail_sales
)
Select 
	shift, 
	count(*) as total_orders
FROM hourly_sale
Group BY shift
				

-- END OF THE PROJECT ---
