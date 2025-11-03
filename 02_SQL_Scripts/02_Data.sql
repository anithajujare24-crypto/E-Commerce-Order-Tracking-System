-- insert sample data
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

insert into order_items (order_id, product_id, quantity, unit_price, subtotal) values (1, 1, 2, 650, 1300);
insert into order_items (order_id, product_id, quantity, unit_price, subtotal) values (2, 3, 1, 900, 900);
insert into order_items (order_id, product_id, quantity, unit_price, subtotal) values (3, 2, 1, 1200, 1200);
insert into order_items (order_id, product_id, quantity, unit_price, subtotal) values (4, 4, 2, 300, 600); 

insert into payments (order_id, amount, payment_mode) values (2, 900, 'card');
insert into payments (order_id, amount, payment_mode) values (3, 1200, 'upi');
-- refunded payment entry
insert into payments (order_id, amount, payment_mode, payment_date) values (4, 600, 'upi', sysdate);

commit;
/
