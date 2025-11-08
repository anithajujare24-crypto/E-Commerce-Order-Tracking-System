-- =========================================================
-- Script Name : 02_Data.sql
-- Project     : E-Commerce Order Tracking System
-- Author      : J. Anitha
-- Purpose     : Insert sample data into database tables
-- =========================================================

insert into customers (customer_name, email, phone, city) values ('meera n', 'meera2@gmail.com', '9876534984', 'bangalore');
insert into customers (customer_name, email, phone, city) values ('vikam s', 'vikam2409@gmail.com', '8970483120', 'hyderabad');
insert into customers (customer_name, email, phone, city) values ('raj k', 'rajkumar@gmail.com', '6309167428', 'chennai');

insert into products (product_name, category, unit_price, stock_qty) values ('laptop', 'electronics', 650, 20);
insert into products (product_name, category, unit_price, stock_qty) values ('Pen drive', 'accessories', 1200, 15);
insert into products (product_name, category, unit_price, stock_qty) values ('tablet', 'electronics', 900, 10);
insert into products (product_name, category, unit_price, stock_qty) values ('usb-c cable', 'accessories', 300, 50); 

insert into orders (customer_id, order_status, payment_status) values (1, 'processing', 'pending');
insert into orders (customer_id, order_status, payment_status) values (2, 'shipped', 'paid');
insert into orders (customer_id, order_status, payment_status) values (3, 'delivered', 'paid');
-- an order cancelled 
insert into orders (customer_id, order_status, payment_status) values (1, 'cancelled', 'refunded');

insert into order_items (order_id, product_id, quantity, unit_price, subtotal) values (5, 1, 2, 650, 1300);
insert into order_items (order_id, product_id, quantity, unit_price, subtotal) values (6, 3, 1, 900, 900);
insert into order_items (order_id, product_id, quantity, unit_price, subtotal) values (7, 2, 1, 1200, 1200);
insert into order_items (order_id, product_id, quantity, unit_price, subtotal) values (8, 4, 2, 300, 600); 

insert into payments (order_id, amount, payment_mode) values (5, 900, 'card');
insert into payments (order_id, amount, payment_mode) values (6, 1200, 'upi');
-- refunded payment entry
insert into payments (order_id, amount, payment_mode) values (8, 7300, 'upi');

insert into order_audit_log(order_id, old_status, new_status, changed_by, remarks) values (5, 'pending', 'shipped', 'admin', 'order_shipped');
commit;

-- Verifying inserted records from all table
select * from orders;
select * from payments;
select * from order_items;
select * from order_audit_log;
/
