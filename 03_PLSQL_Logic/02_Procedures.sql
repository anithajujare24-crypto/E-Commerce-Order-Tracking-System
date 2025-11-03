-- procedures.sql
-- add a new order
create or replace procedure sp_add_order(
    p_customer_id in number,
    p_order_status in varchar2,
    p_payment_status in varchar2
) as
begin
    insert into orders (customer_id, order_status, payment_status)
    values (p_customer_id, p_order_status, p_payment_status);

    insert into order_audit_log(order_id, old_status, new_status, changed_by, remarks)
    values ((select max(order_id) from orders where customer_id = p_customer_id),
            null, p_order_status, user, 'new order created');
end;
/
-- add an order item
create or replace procedure sp_add_order_item(
    p_order_id in number,
    p_product_id in number,
    p_quantity in number
) as
    v_price products.unit_price%type;
    v_subtotal number;
begin
    select unit_price into v_price from products where product_id = p_product_id;

    v_subtotal := v_price * p_quantity;

    insert into order_items (order_id, product_id, quantity, unit_price, subtotal)
    values (p_order_id, p_product_id, p_quantity, v_price, v_subtotal);

    update products
    set stock_qty = stock_qty - p_quantity
    where product_id = p_product_id;
end;
/
-- update order status
create or replace procedure sp_update_order_status(
    p_order_id in number,
    p_new_status in varchar2
) as
    v_old_status orders.order_status%type;
begin
    select order_status into v_old_status from orders where order_id = p_order_id;

    update orders
    set order_status = p_new_status
    where order_id = p_order_id;

    insert into order_audit_log(order_id, old_status, new_status, changed_by, remarks)
    values (p_order_id, v_old_status, p_new_status, user, 'order status updated');
end;
/
-- update payment status
create or replace procedure sp_update_payment_status(
    p_order_id in number,
    p_status in varchar2
) as
begin
    update orders
    set payment_status = p_status
    where order_id = p_order_id;

    insert into order_audit_log(order_id, old_status, new_status, changed_by, remarks)
    values (p_order_id, null, p_status, user, 'payment status updated');
end;
/
-- record payment
create or replace procedure sp_add_payment(
    p_order_id in number,
    p_amount in number,
    p_mode in varchar2
) as
begin
    insert into payments (order_id, amount, payment_mode)
    values (p_order_id, p_amount, p_mode);

    update orders
    set payment_status = 'paid'
    where order_id = p_order_id;

    insert into order_audit_log(order_id, old_status, new_status, changed_by, remarks)
    values (p_order_id, null, 'paid', user, 'payment recorded');
end;
/
-- calculate total for a given order
create or replace procedure sp_calculate_order_total(
    p_order_id in number,
    p_total out number
) as
begin
    select nvl(sum(subtotal), 0)
    into p_total
    from order_items
    where order_id = p_order_id;
end;
/
-- get customer order summary
create or replace procedure sp_get_customer_summary(
    p_customer_id in number
) as
begin
    dbms_output.put_line('customer summary report');

    for rec in (
        select o.order_id, o.order_status, o.payment_status,
               sum(oi.subtotal) as total_amount
        from orders o
        join order_items oi on o.order_id = oi.order_id
        where o.customer_id = p_customer_id
        group by o.order_id, o.order_status, o.payment_status
    ) loop
        dbms_output.put_line('order id: ' || rec.order_id);
        dbms_output.put_line('status: ' || rec.order_status);
        dbms_output.put_line('payment: ' || rec.payment_status);
        dbms_output.put_line('total: ' || rec.total_amount);
    end loop;
end;
/
