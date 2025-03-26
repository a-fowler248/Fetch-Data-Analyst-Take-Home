-- Check if the number of rows in the table matches the csv file
select count(*)
from users;
-- it does

-- General check of a limited number of rows from the table
select *
from users
limit 50;
-- from this I can see my headers came in correctly and blank cells were replaced with null
-- the "Z" in the dates may be an issue when trying to manipulate the dates outside of sql, may want to reformat it

select
    min(created_date),
    max(created_date)
from users;

-- Check unique fields to see if there are outliers
select
    count(*) num_rows,
    count(distinct id) num_ids
from users
--where id is null
;
-- confirming id is a unique identifier with no null values

-- Check how much of each field are null values
select
    state,
    count(*),
    count(*) / 100000 as pct_ttl
from users
group by state;
-- About 5% of the data is missing, and there are 2 additional states present (outside of the 50 states.)  This is most likely including two territories, but would be worth comparing to the States names to cross check before using this data.

select
    language,
    count(*),
    count(*) / 100000 as pct_ttl
from users
group by language;
-- We are missing 30.5% of the user's languages, therefore I would not rely on this field with much confidence as it may be misrepresenting the user base.

-- Other notes:
---- using Looker Studio for visualizations: https://lookerstudio.google.com/reporting/9b1b71c3-e4e0-4d69-a3a4-600b4c04f5d1
---- also using excel for table filters and pivot tables
---- Created Date: This information is present for each user, and the user ID's were created between Apr 2014 - Sep 2025, with more accounts created since 2020.
---- Birth Date: Only 3.7% of the birth dates are missing (filled in here with 2026), with the majority of birthdays occurring between 1954 and 2008.
---- Gender: There are some duplicate fields like "prefer_not_to_say" and "Prefer not to say" that should be combined.  To see how much information is missing, The pie chart combines the fields:
------ blank, prefer_not_to_say, unknown, not_specified, and Prefer not to say.  Only 3.7% of data is Unknown, so it can be used.  We should also note that 62.9% of users are female.

-- Therefore, no further cleaning is needed for this table.