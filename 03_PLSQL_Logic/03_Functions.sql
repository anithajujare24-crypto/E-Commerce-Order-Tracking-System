-- =========================================================
-- Script Name : 03_Functions.sql
-- Project     : E-Commerce Order Tracking System
-- Author      : J. Anitha
-- Purpose     : Defines reusable functions for fetching customer data
--               and calculating order totals.
-- =========================================================

-- =========================================================
-- Function : fn_get_customer_name
-- Purpose  : Returns the customer name for a given customer ID.
-- =========================================================

create or replace function fn_get_customer_name(
    p_customer_id in number
) return varchar2 is
    v_name varchar2(100);
begin
 
 -- trying to fetch the name from the customers table

    select customer_name into v_name
    from customers
    where customer_id = p_customer_id;

    -- if found, return it

    return v_name;

    -- if customer ID doesn’t exist,handle the situation

exception
    when no_data_found then
        return 'unknown';
end;
/

-- =========================================================
-- Function : fn_get_order_total
-- Purpose  : Calculates and returns the total value of all items
--            in a specific order.
-- ==========================================================

create or replace function fn_get_order_total(
    p_order_id in number
) return number is
    v_total number;
begin

    -- sum all item subtotals for the given order
    -- NVL ensures we return 0 instead of NULL if the order has no items

    select nvl(sum(subtotal), 0)
    into v_total
    from order_items
    where order_id = p_order_id;

    -- returns calculated total

    return v_total;

    -- captures any unexpected runtime errors

exception
    when others then
        return 0;
end;
/

-- =========================================================
-- Function : fn_get_order_status
-- Purpose  : Returns the current status of an order using its ID.
-- =========================================================

create or replace function fn_get_order_status(
    p_order_id in number
) return varchar2 is
    v_status varchar2(30);
begin

-- trying to fetch the order status from the orders table

    select order_status
    into v_status
    from orders
    where order_id = p_order_id;

-- if found, returns the status

    return v_status;

     -- if the order_id doesn’t exist, returns this message

exception
    when no_data_found then
        return 'invalid order';
end;
/

-- =========================================================
-- Function : fn_get_customer_total_spent
-- Purpose  : Calculates how much money a customer has spent in total
--            across all their orders.
-- =========================================================

create or replace function fn_get_customer_total_spent(
    p_customer_id in number
) return number is
    v_spent number;
begin

-- calculates the total amount spent by this customer
    -- NVL ensures we return 0 instead of NULL when no orders exist

    select nvl(sum(oi.subtotal), 0)
    into v_spent
    from orders o
    join order_items oi on o.order_id = oi.order_id
    where o.customer_id = p_customer_id;

    -- return calculated spent

    return v_spent;
EXCEPTION

     -- if anything unexpected happens, return 0

    when others THEN
    return 0;
end;
/
commit;