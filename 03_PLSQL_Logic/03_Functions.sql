-- functions.sql
-- get customer name by id
create or replace function fn_get_customer_name(
    p_customer_id in number
) return varchar2 is
    v_name varchar2(100);
begin
    select customer_name into v_name
    from customers
    where customer_id = p_customer_id;

    return v_name;
exception
    when no_data_found then
        return 'unknown';
end;
/

-- get total order amount
create or replace function fn_get_order_total(
    p_order_id in number
) return number is
    v_total number;
begin
    select nvl(sum(subtotal), 0)
    into v_total
    from order_items
    where order_id = p_order_id;

    return v_total;
exception
    when others then
        return 0;
end;
/

-- get current order status
create or replace function fn_get_order_status(
    p_order_id in number
) return varchar2 is
    v_status varchar2(30);
begin
    select order_status
    into v_status
    from orders
    where order_id = p_order_id;

    return v_status;
exception
    when no_data_found then
        return 'invalid order';
end;
/

-- get customer total spent
create or replace function fn_get_customer_total_spent(
    p_customer_id in number
) return number is
    v_spent number;
begin
    select nvl(sum(oi.subtotal), 0)
    into v_spent
    from orders o
    join order_items oi on o.order_id = oi.order_id
    where o.customer_id = p_customer_id;

    return v_spent;
end;
/
