-- Ranking Functions

-- For each Store_ID, assign a row number to each product ordered by Date.
SELECT Store_ID, Category,DATE,
ROW_NUMBER() OVER(PARTITION BY STORE_ID ORDER BY DATE) AS RNK FROM retail.Retail_Inventory_DB

-- Rank all products in each Region based on Units_Sold in descending order.
SELECT PRODUCT_ID, CATEGORY,REGION,
RANK() OVER(PARTITION BY REGION ORDER BY UNITS_SOLD) AS RANKS FROM retail.Retail_Inventory_DB

-- Use DENSE_RANK() to determine the best-selling products in each Category.
SELECT * FROM
(SELECT CATEGORY, PRODUCT_ID, UNITS_SOLD, 
DENSE_RANK() OVER(PARTITION BY CATEGORY ORDER BY UNITS_SOLD DESC) AS BEST_SELLING_RANK FROM retail.Retail_Inventory_DB
) T
WHERE BEST_SELLING_RANK = 1;

-- What's the difference between RANK() and DENSE_RANK()? Illustrate it with an example using product sales.
SELECT STORE_ID, PRODUCT_ID, CATEGORY, PRICE,
RANK() OVER(PARTITION BY REGION ORDER BY PRICE DESC) AS BEST_SELL_RANK,
DENSE_RANK() OVER(PARTITION BY REGION ORDER BY PRICE DESC) AS BEST_SELL_DENSE FROM retail.Retail_Inventory_DB

