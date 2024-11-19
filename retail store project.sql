-- retail sales project
create database Sales_Project;
use Sales_Project;

create table sales
	(
		transactions_id int primary key,
		sale_date date,
		sale_time time,
		customer_id	int,
		gender	varchar(35),
		age	int,
		category varchar(35),	
		quantiy	int,
		price_per_unit float,	
		cogs	float,
		total_sale float
	);
select * from sales
limit 400;

-- removing null values from data (data cleaning) 

select *
from sales 
where 
		transactions_id is null
		or
		sale_date is null
        or
		sale_time is null
        or
		customer_id	is null
        or
		gender	is null
        or
		age	is null
        or
		category is null
        or
		quantiy	is null
        or
		price_per_unit is null
        or
		cogs is null
        or
		total_sale is null;
        
select distinct count(*) 
from sales;
        
-- data Exploration (EDA)

-- how many sales we have ?
select count(*) as total_sale from sales;

-- how many unique customers we have ?
select count(distinct(customer_id)) from sales;

-- how many unique category we have ?
select count(distinct (category)) from sales;

select  distinct category
from sales;

-- business problem

-- 1. write a SQL quary to retrieve all column for sales made on '2022-11-05'
-- 2. write a SQL quary to retrieve all transactions where the category is 'Clothing' and the quantity sold more than 4 in the month of Nov-2022
-- 3. write a SQL quary to calculate the total sales (total_sales) for each category.
-- 4. write a SQL quary to find the average age of customer who purchased item from the 'Beauty' category.
-- 5. write a SQL quary to find all transactions where the total_sales is greater than 1000.
-- 6. write a SQL quary to find the total number of transactions (transactions_id) made by each gender in each category.
-- 7. write a SQL quary to calculate the average sale for each month. find out best selling month in each year.
-- 8. write a SQL quary to find the top 5 customer based on the highest total sales.
-- 9. write a SQL quary to find the number of unique customers who purchased item from each category.
-- 10. write a SQL quary to create each shift and number of orders (example morning <= 12, afternoon <= 12, afternoon between 12 & 17, evening >17)
    
-- 1. write a SQL quary to retrieve all column for sales made on '2022-11-05'

select * from sales
where sale_date = '2022-11-05';

-- 2. write a SQL quary to retrieve all transactions where the category is 'Clothing' and the quantity sold more than 4 in the month of Nov-2022

select  * from sales
where 	CATEGORY  = 'Clothing' and month(sale_date) = 11 and year(sale_date) = 2022 and quantiy >= 4;
 
 -- 3. write a SQL quary to calculate the total sales (total_sales) for each category.
 
 select category, sum(total_sale) as total_sales,
 count(*) as total_order
 from sales
 group by category;
 
 -- 4. write a SQL quary to find the average age of customer who purchased item from the 'Beauty' category.

select round(avg(age),2) as avg_age
from sales
where category = 'Beauty' and quantiy > 1;

-- 5. write a SQL quary to find all transactions where the total_sales is greater than 1000.

select * from sales
where total_sale > 1000;

-- 6. write a SQL quary to find the total number of transactions (transactions_id) made by each gender in each category.

select category, gender, count(*)as total_trans 
from sales
group by category , gender;

-- 7. write a SQL quary to calculate the average sale for each month. find out best selling month in each year.

select  month(sale_date) as month,  year(sale_date) as year, round(avg(total_sale),2)as avg_sale
from sales
group by month(sale_date),year(sale_date)
order by avg_sale desc
limit 2;

-- or

select * from(
select  month(sale_date) as month,  
		year(sale_date) as year, 
		round(avg(total_sale),2)as avg_sale,
        rank() over(partition by year(sale_date) order by avg(total_sale) desc) as level
from sales
group by  1,2
) as t1
where level = 1;
 
-- 8. write a SQL quary to find the top 5 customer based on the highest total sales.

select customer_id ,sum(total_sale) as total 
from sales
group by customer_id
order by  total desc
limit 5;

-- 9. write a SQL quary to find the number of unique customers who purchased item from each category.

select category, count(distinct customer_id) as unique_customer
from sales
group by category;

-- 10. write a SQL quary to create each shift and number of orders 
-- (example morning <= 12, afternoon <= 12, afternoon between 12 & 17, evening >17) [CTE question]

with hourly_sales
as
(
	select *, 
		case 
			when extract(hour from  sale_time) <= 12 then 'morning'
			when extract(hour from  sale_time) >12 and extract(hour from  sale_time) < 17 then 'afternoon'
			else 'evening'
		end as shift
	from sales
)
select shift, count(*) as total_orders
from hourly_sales
group by shift; 


    
    