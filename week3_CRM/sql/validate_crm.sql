-- Task 2

-- Use wild card and like operator to find invalid emails
select * from staging.old
where not email like '%@%.%'; -- % means starts with 'something' random

-- use regexp function for the new data to find invalid email
select * from staging.new
where regexp_matches(email, '[A-Za-z0-9]@[A-Za-z]+\.[A-Za-z]+');

-- combine all three conditions
select * from staging.new
where not regexp_matches(email, '[A-Za-z0-9]@[A-Za-z]+\.[A-Za-z]+')
or not region in ('EU', 'US') or 
not status in ('active', 'inactive');

-- Task 3

create schema if not exists constrained;

create table if not exists constrained.crm_old (
  customer_id integer unique,
  name varchar not null,
  email varchar check(email like '%@%.%'),
  region varchar check(region in ('EU', 'US')),
  status varchar check(status in ('active', 'inactive'))
);

create table if not exists constrained.crm_new (
  customer_id integer unique,
  name varchar not null,
  email varchar check(regexp_matches(email, '[A-Za-z0-9]@[A-Za-z]+\.[A-Za-z]+')),
  region varchar check(region in ('EU', 'US')),
  status varchar check(status in ('active', 'inactive'))
);

insert into constrained.crm_old
select * 
from staging.old
where regexp_matches(email, '[A-Za-z0-9]@[A-Za-z]+\.[A-Za-z]+')
and region in ('EU', 'US') and 
status in ('active', 'inactive');

insert into constrained.crm_new
select * 
from staging.old
where regexp_matches(email, '[A-Za-z0-9]@[A-Za-z]+\.[A-Za-z]+')
and region in ('EU', 'US') and 
status in ('active', 'inactive');

-- Task 4

select customer_id 
from staging.old
except 
select customer_id
from staging.new;

select customer_id 
from staging.new
except 
select customer_id
from staging.old

select customer_id 
from staging.new
intersect 
select customer_id
from staging.old

-- Task 5 (Current v. is buggy i.e not finished)

/* Task 5 */
-- subquery 1: customers only in the old crm system
(SELECT *
FROM staging.old
EXCEPT
SELECT *
FROM staging.new)
UNION
-- subquery 2: customers only in the new crm sytem
(SELECT *
FROM staging.new
EXCEPT
SELECT *
FROM staging.old)
UNION
-- subquery 3: customers violating constraints in old crm system
(SELECT * FROM staging.old
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR
      NOT region IN ('EU', 'US') OR
      NOT status IN ('active', 'inactive'))
UNION
-- subquery 4: customers violating constraints in new crm system
(SELECT * FROM staging.new
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR
      NOT region IN ('EU', 'US') OR
      NOT status IN ('active', 'inactive'))

