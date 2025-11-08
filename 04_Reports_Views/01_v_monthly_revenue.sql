-- =========================================================
-- View Name : v_monthly_revenue
-- Purpose   : Displays total revenue and total number of orders 
--             for each month — a quick monthly sales summary that 
--             helps track business performance
-- =========================================================

create or replace view v_monthly_revenue as
select

-- converts date to month and year

    to_char(o.order_date, 'mon-yyyy') as month_year,

    -- Adds up all payment amounts received during that month

    sum(p.amount) as total_revenue,
    
    -- Counts how many distinct orders were placed in that month

    count(distinct o.order_id) as total_orders

from orders o

    -- joins payments to get the amount per order

join payments p on o.order_id = p.order_id

-- Groups everything by month and year

group by to_char(o.order_date, 'mon-yyyy')

-- Sorts months chronologically

order by to_date(to_char(o.order_date,'mon-yyyy'), 'mon-yyyy');
/
commit;

-- views the monthly sales trend

select * from v_monthly_revenue;
