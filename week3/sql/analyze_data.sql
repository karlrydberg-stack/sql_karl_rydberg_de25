-- Task 2

desc staging.weather; -- Will display column value types

desc
select 
typeof(sunriseTime),
typeof(sunsetTime),
typeof(temperatureHighTime),
typeof(temperatureLowTime),
typeof(windGustTime),
typeof(precipIntensityMaxTime)
from staging.weather;

-- UNIX; seconds counted from a point in time (1979-01-01 00:00:00)

-- Task 3

select count(*), "Country/Region", "Province/State" from staging.weather group by "Country/Region", "Province/State" order by "Country/Region", "Province/State";

-- Task 4

select to_timestamp(sunriseTime) at time zone 'Europe/Stockholm', to_timestamp(sunsetTime) at time zone 'Europe/Stockholm' from staging.weather where "Country/Region" = 'Sweden';

-- Task 5

select 
date_part('year', to_timestamp(sunriseTime)) as year, 
date_part('month', to_timestamp(sunriseTime)) as month,
to_timestamp(max(sunriseTime)) at time zone 'Europe/Stockholm' as late_rise,
to_timestamp(max(sunsetTime)) at time zone 'Europe/Stockholm' as late_set,
((hour(late_set)*60 + minute(late_set)) - (hour(late_rise)*60 + minute(late_rise)))/60 as hour_diff 
from staging.weather 
where "Country/Region" = 'Sweden'
group by year, month
order by month;