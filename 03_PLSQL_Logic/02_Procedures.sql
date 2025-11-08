-- =========================================================
-- Script Name : 02_Procedures.sql
-- Project     : E-Commerce Order Tracking System
-- Author      : J. Anitha
-- Purpose     : Stored procedures to add orders, add items and update order status
-- =========================================================


-- ==============================================
-- Procedure : sp_add_order
-- This procedure adds a new order into the orders table
-- and logs the creation in the order_audit_log table.
-- ==============================================

create or replace procedure sp_add_order(
    p_customer_id in number,
    p_order_status in varchar2,
    p_payment_status in varchar2
) as
begin

-- Inserts a new order for the customer with given status values

    insert into orders (customer_id, order_status, payment_status)
    values (p_customer_id, p_order_status, p_payment_status);

    -- adds a log entry for this new order
    -- here max(order_id) is used to get the latest order placed by that custome

    insert into order_audit_log(order_id, old_status, new_status, changed_by, remarks)
    values ((select max(order_id) from orders where customer_id = p_customer_id),
            null, p_order_status, user, 'new order created');
end;
/

-- ==============================================
-- Procedure : sp_add_order_item
-- This procedure adds an item into the order_items table
-- It calculates the subtotal and updates the stock automatically.
-- ==============================================

create or replace procedure sp_add_order_item(
    p_order_id in number,
    p_product_id in number,
    p_quantity in number
) as
    v_price products.unit_price%type;
    v_subtotal number;
begin

-- fetches the product price from the products table

    select unit_price into v_price from products where product_id = p_product_id;

    -- calculates subtotal = price * quantity

    v_subtotal := v_price * p_quantity;


    -- inserts item details into order_items

    insert into order_items (order_id, product_id, quantity, unit_price, subtotal)
    values (p_order_id, p_product_id, p_quantity, v_price, v_subtotal);

 -- reduce product stock after adding order item

    update products
    set stock_qty = stock_qty - p_quantity
    where product_id = p_product_id;
end;
/
-- updating order status

-- =========================================================
-- Procedure : sp_update_order_status
-- Purpose   : Updates the order status and logs the change
-- =========================================================

create or replace procedure sp_update_order_status(
    p_order_id in number,
    p_new_status in varchar2
) as

-- fetches the old status of the order

    v_old_status orders.order_status%type;
begin
    select order_status into v_old_status from orders where order_id = p_order_id;

-- updates the order with the new status

    update orders
    set order_status = p_new_status
    where order_id = p_order_id;


    -- log the status update in audit table

    insert into order_audit_log(order_id, old_status, new_status, changed_by, remarks)
    values (p_order_id, v_old_status, p_new_status, user, 'order status updated');
end;
/

-- =========================================================
-- Procedure : sp_add_payment
-- Purpose   : Records a new payment transaction for an order
-- =========================================================


create or replace procedure sp_update_payment_status(
    p_order_id in number,
    p_status in varchar2
) as
begin
    update orders
    set payment_status = p_status
    where order_id = p_order_id;

 -- inserts payment transaction details into payments table

    insert into order_audit_log(order_id, old_status, new_status, changed_by, remarks)
    values (p_order_id, null, p_status, user, 'payment status updated');
end;
/

-- =========================================================
-- Procedure : sp_add_payment
-- Purpose   : Records a new payment, updates its order status,
--             and logs the transaction in the audit table.
-- =========================================================

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

-- =========================================================
-- Procedure : sp_calculate_order_total
-- Purpose   : Calculates the total cost of an order based on
--             all items in that order.
-- =========================================================

create or replace procedure sp_calculate_order_total(
    p_order_id in number,
    p_total out number
) as
begin

 -- sum up all item subtotals for this order
    -- NVL is used to avoid returning NULL if no items exist

    select nvl(sum(subtotal), 0)
    into p_total
    from order_items
    where order_id = p_order_id;
end;
/

-- =========================================================
-- Procedure : sp_get_customer_summary
-- Purpose   : Displays all orders, their status, and total value
--             for a given customer. Useful for reporting.
-- =========================================================

create or replace procedure sp_get_customer_summary(
    p_customer_id in number
) as
begin
    dbms_output.put_line('customer summary report');

-- loop through each order for the given customer

    for rec in (
        select o.order_id, o.order_status, o.payment_status,
               sum(oi.subtotal) as total_amount
        from orders o
        join order_items oi on o.order_id = oi.order_id
        where o.customer_id = p_customer_id
        group by o.order_id, o.order_status, o.payment_status
    ) loop

    -- prints each order’s details neatly to the console

        dbms_output.put_line('order id: ' || rec.order_id);
        dbms_output.put_line('status: ' || rec.order_status);
        dbms_output.put_line('payment: ' || rec.payment_status);
        dbms_output.put_line('total: ' || rec.total_amount);
    end loop;
end;
/
commit;