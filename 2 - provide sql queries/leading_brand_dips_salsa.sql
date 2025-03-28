--Which is the leading brand in the Dips & Salsa category?

--Assuming that "leading" here means the brand with the most receipts scanned across the full transaction data (purchase dates from 6/12/24 - 9/8/24).
select
    p.BRAND,
    count(distinct t.RECEIPT_ID) NUM_RECEIPTS
from transactions as t
    left join products as p
        on t.barcode = p.barcode
where p.category_2 = 'Dips & Salsa'
group by p.brand
order by num_receipts desc
limit 1;




-- --Exploration to check the low number of receipts per brand:
-- select count(*)
-- from transactions;

-- select
--     count(*),
--     count(distinct t.barcode) t_barcodes,
--     count(distinct p.barcode) p_barcodes,
--     sum(case when p.brand is null then 1 else 0 end) as null_brand,
--     sum(case when p.brand is not null then 1 else 0 end) as has_brand,
--     sum(case when p.category_2 = 'Dips & Salsa' then 1 else 0 end) as cat_dips_salsa
-- from transactions as t
--     left join products as p
--         on t.barcode = p.barcode;

-- --Conclusion:
-- -- We have 50,000 total transactions
-- -- There are 11,028 distinct barcodes in the transactions table, but only 6,561 match barcodes in the products table
-- -- Less than half of the transactions have Brand information (24,092 of 50,000)
-- -- Only 652 of the transactions have the category "Dips & Salsa"
-- -- Therefore, it makes sense that the number of receipts per brand is low.