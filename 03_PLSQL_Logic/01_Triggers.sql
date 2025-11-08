-- =========================================================
-- Script Name : Triggers.sql
-- Project     : E-Commerce Order Tracking System
-- Author      : J. Anitha
-- Purpose     : Defines PL/SQL triggers to automate business logic
-- =========================================================


-- =========================================================
-- Trigger : trg_check_stock
-- Purpose : Prevent inserting order items when stock is insufficient
-- =========================================================

create or replace trigger trg_check_stock
before insert on order_items
for each row
declare
  v_stock products.stock_qty%type;-- variable to store current stock for the product
begin

-- fetches available stock for the given product

  select stock_qty into v_stock from products where product_id = :new.product_id;

    -- if ordered quantity exceeds available stock, raise an exception

  if v_stock < :new.quantity then
    raise_application_error(-20001, 'insufficient stock for product id: ' || :new.product_id);
  end if;
end;
/

-- =========================================================
-- Trigger : trg_reduce_stock
-- Purpose : Reduce product stock quantity after an order item
--           is successfully inserted
-- =========================================================

create or replace trigger trg_reduce_stock
after insert on order_items
for each row
begin

-- subtracts the ordered quantity from product stock

  update products set stock_qty = stock_qty - :new.quantity
    where product_id = :new.product_id;
  
end;
/

-- =========================================================
-- Trigger : trg_order_audit
-- Purpose : Log every change in order status into audit table
-- =========================================================


create or replace trigger trg_order_audit
after update of order_status on orders
for each row
when (old.order_status <> new.order_status)
begin

-- inserting details into audit log when order status changes

  insert into order_audit_log(order_id, old_status, new_status, changed_by, remarks)
    values (:old.order_id, :old.order_status, :new.order_status, user, 'order status changed');
end;
/

-- =========================================================
-- Trigger : trg_new_order_log
-- Purpose : Log new order creation events into audit table
-- =========================================================

create or replace trigger trg_new_order_log
after insert on orders
for each row
begin

-- records new order creation in the audit log

  insert into order_audit_log(order_id, old_status, new_status, changed_by, remarks)
    values (:new.order_id, null, :new.order_status, user, 'new order created');
end;
/
commit;
