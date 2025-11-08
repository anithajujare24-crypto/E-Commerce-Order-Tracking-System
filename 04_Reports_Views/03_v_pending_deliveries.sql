-- ====================================================
-- View Name : v_pending_deliveries 
-- Purpose : Lists all orders that are still in process — 
           -- not yet delivered or cancelled.
-- ====================================================

create or replace view v_pending_deliveries as
select
    o.order_id,
    c.customer_name,
    o.order_status,
    o.payment_status,
    trunc(o.order_date) as order_date
from orders o
join customers c on o.customer_id = c.customer_id-- links each order to the customer
where lower(o.order_status) not in ('delivered', 'cancelled')-- excludes completed or cancelled orders
order by o.order_date desc;-- lists the most recent orders at the top
/
/
select * from v_pending_deliveries;
commit;