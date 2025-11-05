-- v_monthly_revenue.sql

create or replace view v_monthly_revenue as
select
    to_char(o.order_date, 'mon-yyyy') as month_year,
    sum(p.amount) as total_revenue,
    count(distinct o.order_id) as total_orders
from orders o
join payments p on o.order_id = p.order_id
group by to_char(o.order_date, 'mon-yyyy')
order by to_date(to_char(o.order_date,'mon-yyyy'), 'mon-yyyy');
/
commit;
select * from v_monthly_revenue;
