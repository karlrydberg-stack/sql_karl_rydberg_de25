-- create table
create table if not exists joined_table as (select * from read_csv_auto('data\joined_table.csv'))

-- b
select count(distinct order_id) from joined_table;

-- c
select count(distinct product_id) from joined_table;

-- d
select count(DISTINCT order_id) from joined_table where product_name = 'Surly Straggler - 2016';
select sum(quantity*list_price*(1-discount)) from joined_table where product_name = 'Surly Straggler - 2016';

-- e
select count(distinct order_id) from joined_table where customer_city = 'San Angelo' or customer_city = 'Orchard Park' or customer_city = 'Merrick';

-- f
alter table joined_table
add manager_name varchar;
insert into joined_table (manager_id, manager_name)
values (1, 'Amy Andersson'),
(2, 'Bill Berg'),
(5, 'Cathy Larsson'),
(7, 'Davis Lam');