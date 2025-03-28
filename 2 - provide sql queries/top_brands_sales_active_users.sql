-- What are the top 5 brands by sales among users that have had their account for at least six months?

select
    p.BRAND,
    sum(FINAL_SALE) as SALES
from transactions as t
    left join products as p
        on t.barcode = p.barcode
    left join users as u
        on t.user_id = u.id
where u.created_date <= date('now', '-6 months')
    and brand is not null
group by p.brand
order by sales desc
limit 5;




-- --Exploration to check the limited number of sales per top brands:
-- select
--     count(*) as total_users,
--     sum(case when created_date <= date('now', '-6 months') then 1 else 0 end) as active_user,
--     sum(case when created_date > date('now', '-6 months') then 1 else 0 end) as new_user
-- from users;

-- select
--     count(*) as num_transactions,
--     count(distinct u.ID) as num_users,
--     sum(case when u.ID is null then 1 else 0 end) as null_user_transactions
-- from transactions as t
--     left join users as u
--         on t.user_id = u.id;

-- select
--     count(*) as num_transactions,
--     count(distinct t.barcode) t_barcodes,
--     count(distinct p.barcode) p_barcodes,
--     sum(case when p.brand is null then 1 else 0 end) as ct_null_brand,
--     sum(case when p.brand is not null then 1 else 0 end) as ct_has_brand,
--     sum(FINAL_SALE) sales,
--     sum(case when p.brand is null then FINAL_SALE else 0 end) as null_brand_sales,
--     sum(case when p.brand is not null then FINAL_SALE else 0 end) as has_brand_sales
-- from transactions as t
--     left join products as p
--         on t.barcode = p.barcode;

-- select
--     count(*) as num_transactions,
--     count(distinct u.ID) as num_users,
--     count(distinct t.barcode) t_barcodes,
--     count(distinct p.barcode) p_barcodes,
--     sum(case when p.brand is not null then 1 else 0 end) as ct_has_brand,
--     sum(case when p.brand is not null then FINAL_SALE else 0 end) as has_brand_sales,
--     sum(case when u.ID is not null and p.brand is not null then 1 else 0 end) ct_user_brand_transaction,
--     sum(case when u.ID is not null and p.brand is not null then FINAL_SALE else 0 end) sales_user_brand,
--     count(distinct p.brand) ct_brands,
--     sum(case when u.ID is not null and p.brand is not null then FINAL_SALE else 0 end) / count(distinct p.brand) pot_avg_sales_per_brand --just to get an idea
-- from transactions as t
--     left join products as p
--         on t.barcode = p.barcode
--     left join users as u
--         on t.user_id = u.id;

-- --Conclusion
-- -- We have 100,000 users, all of which were created more than 6 months ago.
-- -- We have 50,000 transactions that were completed by 17,694 users, but only 91 match to the users table.
-- -- There are 11,028 distinct barcodes in the transactions table, but only 6,561 match barcodes in the products table
-- -- Less than half of the transactions have Brand information (24,092 of 50,000) which account for $96,748.45 of the total $171,614.40 sales.
-- -- Therefore, it makes sense that the sales per brand is low.