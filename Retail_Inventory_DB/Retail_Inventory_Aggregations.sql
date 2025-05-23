-- Aggregate Window Functions

-- Write a query to calculate the total units sold per category using a window function.
select category,
units_sold,
sum(units_sold) over(partition by category) as total,
sum(units_sold) over(partition by category order by units_sold) as running_total,
sum(units_sold) over(partition by category order by units_sold rows between unbounded preceding and 2 following) as rolling_total
from retail.Retail_Inventory_DB

-- Find the average discount per region across all products using a window function.
select * from retail.Retail_Inventory_DB

select region, 
avg(discount) over(partition by region) as discount from retail.Retail_Inventory_DB
