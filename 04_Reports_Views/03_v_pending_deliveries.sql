-- v_pending_deliveries.sql
-- list of orders not yet delivered

create or replace view v_pending_deliveries as
select
    o.order_id,
    c.customer_name,
    o.order_status,
    o.payment_status,
    trunc(o.order_date) as order_date
from orders o
join customers c on o.customer_id = c.customer_id
where lower(o.order_status) not in ('delivered', 'cancelled')
order by o.order_date desc;
/
select * from v_pending_deliveries;
