-- Create database
CREATE DATABASE  walmartSales;

-- Create table
CREATE TABLE  sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
); 
-- Data cleaning
SELECT
	*
FROM sales;


-- Add the time_of_day column
SELECT
    time,
    (CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END) AS time_of_day
FROM sales;


ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

-- For this to work turn off safe mode for update
-- Edit > Preferences > SQL Edito > scroll down and toggle safe mode
-- Reconnect to MySQL: Query > Reconnect to server
UPDATE sales
SET time_of_day = (
	CASE
		WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END
);


-- Add day_name column
SELECT
	date,
	to_char(date,'day')
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = to_char(date,'day');


-- Add month_name column
SELECT
	date,
	to_char(date,'month')
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = to_char(date,'month');
            -- Generic Question
-- How many unique cities does the data have?
select distinct city from sales;

--In which city is each branch?
select distinct branch,city from sales order by branch;

            -- Product
--How many unique product lines does the data have?
select distinct product_line from sales;

--What is the most common payment method
select distinct payment,count(1) payments from sales group by payment order by count(1) desc;

--What is the most selling product line?
select  product_line,count(1) orders from sales group by product_line order by orders desc;

--What is the total revenue by month
select to_char(date,'month') as month,round(sum(total)) revenue from sales group by month order by revenue desc;

--What month had the largest COGS?
select to_char(date,'month') as month,round(sum(unit_price*quantity)) COG from sales group by month;

--What product line had the largest revenue?
select product_line,round(sum(total)) revenue from sales group by product_line order by revenue desc;

--What is the city with the largest revenue?
select city,round(sum(total)) revenue from sales group by city order by revenue desc

--what product line had the largest VAT?
select product_line,round(sum(tax_pct)*sum(unit_price*quantity)) VAT
from sales
group by product_line
order by vat desc;

--Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
select product_line,case when sum(quantity)>avg(quantity) then 'Good' else 'Bad' end Sales_Statue 
from sales group by product_line;

--Which branch sold more products than average product sold?
select branch,count(quantity) as product_sold 
from sales 
group by branch 
having count(quantity)>avg(quantity);

--What is the most common product line by gender?
with cte as(
select gender,product_line,sum(quantity) as Total_qunatity_sold,dense_rank() over(partition by gender order by sum(quantity) desc)
from sales
group by gender,product_line)
select * from cte where dense_rank=1;

--What is the average rating of each product line?
select product_line,round(avg(rating)::numeric,2) 
from sales 
group by product_line;

                      --Sales
--Number of sales made in each time of the day per weekday
select time_of_day,count(1) sales 
from sales 
group by time_of_day
order by count(1) desc

--Which of the customer types brings the most revenue?
select customer_type,round(sum(total)::numeric,2) revenue 
from sales
group by customer_type
order by sum(total) desc;

--Which city has the largest tax/VAT percent?
select city,round(avg(tax_pct)::numeric,2) tax_pct
from sales
group by city
order by round(avg(tax_pct)::numeric,2) desc;

--Which customer type pays the most in VAT?
select customer_type,round(avg(tax_pct)::numeric,2) vat
from sales
group by customer_type
order by round(avg(tax_pct)::numeric,2) desc;

                       --Customer

-- How many unique customer types does the data have?
select distinct customer_type from sales;

-- How many unique payment methods does the data have?
select distinct payment from sales;

-- What is the most common customer type?
select customer_type,count(1) count 
from sales 
group by customer_type
order by count(1) desc;

-- Which customer type buys the most?
select customer_type,count(1) orders 
from sales 
group by customer_type
order by count(1) desc;

-- What is the gender of most of the customers?
select gender,count(1) customers 
from sales
group by gender
order by count(1) desc;

-- What is the gender distribution per branch?
select branch,gender,count(1) count
from sales
group by branch,gender
order by branch asc;

-- Which time of the day do customers give most ratings?
select time_of_day,round(avg(rating)::numeric,2) avg_rating
from sales
group by time_of_day
order by round(avg(rating)::numeric,2) desc;

-- Which time of the day do customers give most ratings per branch?
select branch,time_of_day,round(avg(rating)::numeric,2) avg_rating
from sales
group by time_of_day,branch
order by branch,round(avg(rating)::numeric,2) desc;


-- Which day fo the week has the best avg ratings?
select day_name,round(avg(rating)::numeric,2) avg_rating-- Which day fo the week has the best avg ratings? avg_rating
from sales
group by day_name
order by round(avg(rating)::numeric,2) desc;

-- Which day of the week has the best average ratings per branch?
with cte as
(select branch,day_name,round(avg(rating)::numeric,2),dense_rank() over(partition by branch order by avg(rating)) rank
from sales
group by branch,day_name)
select * from cte where rank=1;

