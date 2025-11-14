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