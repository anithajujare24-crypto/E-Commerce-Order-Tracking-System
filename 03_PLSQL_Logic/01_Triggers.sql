
-- triggers.sql
-- prevent inserting order items when stock is insufficient
create or replace trigger trg_check_stock
before insert on order_items
for each row
declare
  v_stock products.stock_qty%type;
begin
  select stock_qty into v_stock from products where product_id = :new.product_id;
  if v_stock < :new.quantity then
    raise_application_error(-20001, 'insufficient stock for product id: ' || :new.product_id);
  end if;
end;
/

-- reduce stock after order item added (only after insert succeeded)
create or replace trigger trg_reduce_stock
after insert on order_items
for each row
begin
  update products set stock_qty = stock_qty - :new.quantity
    where product_id = :new.product_id;
  
end;
/

-- log order status changes
create or replace trigger trg_order_audit
after update of order_status on orders
for each row
when (old.order_status <> new.order_status)
begin
  insert into order_audit_log(order_id, old_status, new_status, changed_by, remarks)
    values (:old.order_id, :old.order_status, :new.order_status, user, 'order status changed');
end;
/

-- log new orders
create or replace trigger trg_new_order_log
after insert on orders
for each row
begin
  insert into order_audit_log(order_id, old_status, new_status, changed_by, remarks)
    values (:new.order_id, null, :new.order_status, user, 'new order created');
end;
/
commit;
