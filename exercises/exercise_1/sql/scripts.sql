update cleaned_salaries
set employment_type = 'Contract'
where employment_type = 'CT';

update cleaned_salaries
set employment_type = 'Part Time'
where employment_type = 'PT';

update cleaned_salaries
set employment_type = 'Full Time'
where employment_type = 'FT';

update cleaned_salaries
set company_size = 'Free Lance'
where company_size = 'FL';

update cleaned_salaries
set company_size = 'Medium'
where company_size = 'M';

update cleaned_salaries
set company_size = 'Large'
where company_size = 'L';

update cleaned_salaries
set company_size = 'Small'
where company_size = 'S';

alter table cleaned_salaries
add column salary_in_sek integer;

update cleaned_salaries
set salary_in_sek = round(salary_in_usd * 9.55);

alter table cleaned_salaries
add column salary_in_sek_monthly integer;

update cleaned_salaries
set salary_in_sek_monthly = round((salary_in_usd * 9.55)/12);

alter table cleaned_salaries
add column salary_level varchar;

update cleaned_salaries
set salary_level =
case 
when salary_in_sek_monthly < 50000 then 'Low'
when salary_in_sek_monthly >= 50000 and salary_in_sek_monthly < 100000 then 'Medium'
when salary_in_sek_monthly >= 100000 and salary_in_sek_monthly < 150000 then 'High'
when salary_in_sek_monthly >= 150000 then 'Insanely High'
else null
end;

create table transformed_salaries as 
select experience_level, employment_type, job_title, salary_in_sek_monthly, salary_in_sek, remote_ratio, company_size, salary_level 
from cleaned_salaries;

select job_title, count(job_title), salary_level from transformed_salaries group by job_title, salary_level;

select median(salary_in_sek_monthly), mean(salary_in_sek_monthly), experience_level from transformed_salaries group by experience_level;