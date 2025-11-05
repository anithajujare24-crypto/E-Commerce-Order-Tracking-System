-- v_top_customers.sql
-- top 3 customers based on total spending

create or replace view v_top_customers as
select
    c.customer_name,
    sum(oi.subtotal) as total_spent,
    count(distinct o.order_id) as total_orders
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by c.customer_name
order by total_spent desc
fetch first 3 rows only;
/
select * from v_top_customers;
commit;