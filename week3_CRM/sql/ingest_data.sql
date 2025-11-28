create schema if not exists staging;

create table if not exists staging.old as (select * from read_csv_auto('data\crm_old.csv'));

create table if not exists staging.new as (select * from read_csv_auto('data\crm_new.csv'));