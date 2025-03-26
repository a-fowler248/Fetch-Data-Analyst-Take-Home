-- Check if the number of rows in the table matches the csv file
select count(*)
from products;
-- it does

-- General check of a limited number of rows from the table
select *
from products
limit 50;
-- from this I can see my headers came in correctly, blank cells were replaced with null, and special characters ' & came through
-- Problem: Barcode was brought in as a number and therefore lost the leading zeros. Also note that there are barcodes of different lengths, so will need to set as text.
---- only missing 0.48% of the field so that is acceptable

-- Challenging: There are blanks in each column, no one column is fully populated

-- Check Category_1
select
    CATEGORY_1,
    count(*) as ct,
    count(*) / 845552 as pct_ttl
from products
group by CATEGORY_1
order by ct desc;
-- missing 0.01%, this is the most populated field

-- Check Brand
select
    brand,
    count(*) as ct,
    count(*) / 845552 as pct_ttl
from products
group by brand
order by ct desc;
-- missing a brand for ~27% of the rows