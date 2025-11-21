create schema if not exists staging;

create table if not exists staging.squad as (select * from read_csv_auto('data\squad.csv'))