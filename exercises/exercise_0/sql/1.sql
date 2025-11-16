-- Create table with assorted home data
create table if not exists hemnet_data as (select * from read_csv_auto('data\hemnet_data_clean.csv'));

-- b
select * from hemnet_data;

-- c
select count(address) from hemnet_data;

-- d
desc hemnet_data;

-- e
select * from hemnet_data order by final_price desc limit 5;

-- f
select * from hemnet_data order by final_price asc limit 5;

-- g
select min(final_price) from hemnet_data;
select max(final_price) from hemnet_data;
select sum(final_price) / count(final_price) from hemnet_data;
select median(final_price) as median_price from hemnet_data;

-- h
select min(price_per_area) from hemnet_data;
select max(price_per_area) from hemnet_data;
select sum(price_per_area) / count(price_per_area) from hemnet_data;
select median(price_per_area) as median_price from hemnet_data;

-- i
select count(distinct commune) from hemnet_data;

-- j
select count(final_price)/500 from hemnet_data where final_price > 10000000;