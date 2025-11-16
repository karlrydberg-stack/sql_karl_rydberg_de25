create schema if not exists staging;

create table if not exists staging.brandss as (select * from read_csv_auto('data\brands.csv'));