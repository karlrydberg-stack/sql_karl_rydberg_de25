create schema if not exists staging;

create table if not exists staging.weather as (select * from read_csv_auto('data\daily_weather_2020.csv'));