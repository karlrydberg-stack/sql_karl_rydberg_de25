-- Create table, insert values

create table if not exists github_repo (
    content varchar,
    week int,
    content_type varchar
);

insert into github_repo (content, week, content_type) values
('00_intro', 44, 'lecture'),
('01_course_structure', 44, 'lecture'),
('02_setup_duckdb', 43, 'lecture'),
('03_sql_introduction', 43, 'lecture'),
('04_querying_data', 43, 'lecture'),
('exercise_0.md', 46, 'exercise'),
('exercise_1.md', 44, 'exercise'),
('exercise_2.md', 44, 'exercise'),
('exercise_3.md', 47, 'exercise');

-- a
select * from github_repo where content_type = 'exercise';

-- b
select * from github_repo where content_type = 'lecture';

-- c
select * from github_repo where week = 48;

-- d
select * from github_repo where week > 46 and week < 50;

-- e
select count(content_type) from github_repo where content_type = 'lecture';

-- f
select count(content_type) from github_repo where not content_type = 'lecture';

-- g
select distinct content_type from github_repo;

-- h
delete from github_repo where content = '02_setup_duckdb';
insert into github_repo values ('02_setup_duckdb', 43, 'lecture');

-- i
select * from github_repo order by week asc;