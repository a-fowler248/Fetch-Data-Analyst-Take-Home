-- Check if the number of rows in the table matches the csv file
select count(*)
from transactions;
-- it does

-- General check of a limited number of rows from the table
select *
from transactions
limit 50;
-- from this I can see my headers came in correctly
-- the "Z" in the dates may be an issue when trying to manipulate the dates outside of sql, may want to reformat it

-- Problem: Barcode was brought in as a number and replaced the values with leading zeros as null. Also note that there are barcodes of different lengths, so will need to set as text.
---- Once that is fixed, there are still 11.5% of receipts without a barcode, so they will not be able to be matched to products.
---- There is also a value of -1 which is likely a typo.

-- Problem: The Final_Quantity has the values 1 and zero, the zeros will need to be corrected to 0 so the field is numeric.

-- Challenging to understand: 
----Where Final_Quantity is zero, there is a final_sale amount
----Where Final_Sale is blank, there is a Final_Quantity >= 0
----Where Final_Sale is 0, the Final_Quantity is equal to zero, 1, 2 or 6.

