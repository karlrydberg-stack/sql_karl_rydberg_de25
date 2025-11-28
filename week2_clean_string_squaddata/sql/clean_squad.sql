select
    title,
    context
from
    staging.squad
where
    title not in context;

-- task2
select
    title,
    context instr(context, title)
from
    staging.squad
where
    not regexp_matches(context, title);

-- task 2
select
    *
from
    staging.squad
where
    context like concat(title, '%');

-- task 3 Problematic varsion 1 
select
    *
from
    staging.squad
where
    regexp_matches(context, concat('^', title));

-- task 3 better
select
    answers [18:],
    -- slicing
    answers [19],
    -- indexing
    case
        when answers [18] = ',' then null
        else answers [18:]
    end as stripped_answer,
    instr(stripped_answer, '''') as first_quotation_index,
    -- a single quotation need to be typed as two quotations
    stripped_answer [:first_quotation_index-1] as first_answer,
    answers
from
    staging.squad;

-- task 4 w/o regexp
select
    regexp_extract(answers, '''([A-Za-z0-9 ,]+)'',') as first_answer,
    regexp_extract(answers, '''([^'']+)'',') as first_answer_1,
    answers
from
    staging.squad;

-- task 5 w regexp