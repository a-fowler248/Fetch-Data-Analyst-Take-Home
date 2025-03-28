--What are the top 5 brands by receipts scanned among users 21 and over?

with cte_users_age as (
    select 
        ID,
        BIRTH_DATE,
        (strftime('%Y', 'now') - strftime('%Y', BIRTH_DATE)) - 
            (strftime('%m-%d', 'now') < strftime('%m-%d', BIRTH_DATE)) as age
    from users
    )
select
    p.BRAND,
    count(distinct t.RECEIPT_ID) NUM_RECEIPTS
from transactions as t
    left join products as p
        on t.barcode = p.barcode
    left join cte_users_age as u
        on t.user_id = u.id
where age >= 21
    and p.BRAND is not null
group by p.BRAND
order by NUM_RECEIPTS desc
limit 5;




-- --Exploration to check the limited number of receipts per top brands:
-- with cte_users_age as (
--     select 
--         ID,
--         BIRTH_DATE,
--         (strftime('%Y', 'now') - strftime('%Y', BIRTH_DATE)) - 
--             (strftime('%m-%d', 'now') < strftime('%m-%d', BIRTH_DATE)) as age
--     from users
--     )
-- select
--     count(*) as total_users,
--     sum(case when age is null then 1 else 0 end) as null_age,
--     sum(case when age is not null then 1 else 0 end) as has_age
-- from cte_users_age;

-- with cte_users_age as (
--     select 
--         ID,
--         BIRTH_DATE,
--         (strftime('%Y', 'now') - strftime('%Y', BIRTH_DATE)) - 
--             (strftime('%m-%d', 'now') < strftime('%m-%d', BIRTH_DATE)) as age
--     from users
--     ),
-- cte_transaction_ages as (
--     select
--         u.id,
--         u.age,
--         t.user_id,
--         count(*) as num_transactions
--     from transactions as t
--         left join cte_users_age as u on t.user_id = u.ID
--     group by u.id, u.age, t.user_id
--     )
-- select
--     sum(num_transactions) as ttl_transactions,
--     count(distinct user_id) as transaction_num_users,
--     count(distinct id) as users_num_users,
--     sum(case when age is null then 1 else 0 end) as null_age,
--     sum(case when age is not null then 1 else 0 end) as has_age
-- from cte_transaction_ages;

-- --Conclusion:
-- -- We have 100,000 users and 50,000 transactions.
-- -- Only 17,694 users completed those 50,000 transactions.
-- -- Of those 17,694, only 91 match to the users table and we have age data for 90.
-- -- Therefore, it makes sense that the number of receipts per brand is limited.