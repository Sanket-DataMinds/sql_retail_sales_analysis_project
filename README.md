# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `Sales_Project`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Sales_Project`.
- **Table Creation**: A table named `sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
 
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
-- how many sales we have ?
select count(*) as total_sale from sales;

-- how many unique customers we have ?
select count(distinct(customer_id)) from sales;

-- how many unique category we have ?
select count(distinct (category)) from sales;
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


DELETE FROM sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select *
from sales
where sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
select  *
from sales
where CATEGORY  = 'Clothing'
        and month(sale_date) = 11
        and year(sale_date) = 2022
        and quantiy >= 4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select
    category,
    sum(total_sale) as total_sales,
    count(*) as total_order
from sales
group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select
    round(avg(age),2) as avg_age
from sales
where category = 'Beauty'
      and quantiy > 1;
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select * from sales
where total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select
    category,
    gender,
    count(*)as total_trans 
from sales
group by category , gender;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
select
    month(sale_date) as month,
    year(sale_date) as year,
    round(avg(total_sale),2)as avg_sale
from sales
group by month(sale_date),year(sale_date)
order by avg_sale desc
limit 2;

-- or

select * from
(
        select  month(sale_date) as month,  
        		year(sale_date) as year, 
        		round(avg(total_sale),2)as avg_sale,
                rank() over(partition by year(sale_date) order by avg(total_sale) desc) as level
        from sales
        group by  1,2
) as t1
where level = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select
    customer_id ,
    sum(total_sale) as total 
from sales
group by customer_id
order by  total desc
limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select
    category,
    count(distinct customer_id) as unique_customer
from sales
group by category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

 
Thank you for your support, and I look forward to connecting with you!
