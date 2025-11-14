create schema if not exists staging;

create table if not exists staging.joines_table as (select * from read_csv_auto('data\joined_table.csv'))