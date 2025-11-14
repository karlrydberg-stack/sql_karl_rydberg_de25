/* -----------
multi
line
commenting

   Query the data
   -----------*/

-- overview of data 

desc;

desc staging.joines_table;

-- select all or some columns

select * from staging.joines_table;

select order_date, customer_first_name, customer_last_name, product_name from staging.joines_table;

-- filter rows with where class

select order_date, customer_first_name, customer_last_name, product_name from staging.joines_table where customer_first_name = 'Marvin';

-- create new table for order status description

create table if not exists staging.status (
    order_status integer, 
    order_status_description varchar
);

select * from staging.status;

insert into staging.status values 
(1, 'Pending'),
(2, 'Processing'),
(3, 'Rejected'),
(4, 'Completed');

-- join two tables

select j.order_id, j.order_status, s.order_status_description from staging.joines_table j
join staging.status s on j.order_status = s.order_status;

-- sort the rows by order_status
-- order by ascending or descending

select j.order_id, j.order_status, s.order_status_description from staging.joines_table j
join staging.status s on j.order_status = s.order_status order by j.order_status asc;

/* ----------------------------
   Investigate unique customers
   ----------------------------*/

-- distinct 

select distinct order_id from staging.joines_table order by order_id desc;

-- find unique value of customer_id

select distinct customer_id from staging.joines_table order by customer_id asc;

-- It is 'Justina Jenkins' that is the issue
-- This can be found out by one window function

select * from staging.joines_table where customer_first_name = 'Justina' and customer_last_name = 'Jenkins';

/*
    Introduce aggregation
*/

-- aggregate over rows
-- there are different ways of aggregation (max, minimum, et cetera)
-- what is the total revenue from all orders

select round(sum(quantity*list_price)) as total_revenue from staging.joines_table;

-- try other aggregation methods

select round(min(quantity*list_price)) as min_revenu, round(max(quantity*list_price)) as max_revenue from staging.joines_table;

/*==============
    CASE/WHEN
  ==============*/

-- similar if..else in other languages

-- we can replace the order_status column to some description

select order_id, product_name, case order_status when 1 then 'pending' when 2 then 'processing' when 3 then 'rejected' when 4 then 'completed' end as order_status_description from staging.joines_table;