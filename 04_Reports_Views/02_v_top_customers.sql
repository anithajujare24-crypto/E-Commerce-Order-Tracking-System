-- ========================================================= 
-- View Name : v_top_customers 
-- Purpose : Finds the top 3 customers based on how much they’ve spent
-- Helps identify loyal or high-value customers.
-- =========================================================

create or replace view v_top_customers as
select
    c.customer_name,
    sum(oi.subtotal) as total_spent,-- total amount of the customer spent
    count(distinct o.order_id) as total_orders-- counts separate orders they placed
from customers c
join orders o on c.customer_id = o.customer_id-- links customers with their orders
join order_items oi on o.order_id = oi.order_id-- links orders with the actual purchased items
group by c.customer_name-- calculates totals per customer
order by total_spent desc-- sorts by highest spender first
fetch first 3 rows only;-- limit to top 3 customers 
/
select * from v_top_customers;
commit;