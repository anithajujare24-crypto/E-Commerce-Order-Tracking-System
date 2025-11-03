-- insert_data.sql

-- CUSTOMERS
INSERT INTO customers (customer_name, email, phone, city) VALUES ('Anitha J', 'anitha@example.com', '9999999991', 'Bangalore');
INSERT INTO customers (customer_name, email, phone, city) VALUES ('Ravi Kumar', 'ravi@example.com', '9999999992', 'Hyderabad');
INSERT INTO customers (customer_name, email, phone, city) VALUES ('Sneha R', 'sneha@example.com', '9999999993', 'Chennai');

-- PRODUCTS
INSERT INTO products (product_name, category, unit_price, stock_qty)
VALUES ('Wireless Mouse', 'Electronics', 650, 200);
INSERT INTO products (product_name, category, unit_price, stock_qty)
VALUES ('Laptop Bag', 'Accessories', 1200, 150);
INSERT INTO products (product_name, category, unit_price, stock_qty)
VALUES ('Keyboard', 'Electronics', 900, 100);

-- ORDERS
INSERT INTO orders (customer_id, order_status, payment_status)
VALUES (1, 'Processing', 'Pending');
INSERT INTO orders (customer_id, order_status, payment_status)
VALUES (2, 'Shipped', 'Paid');
INSERT INTO orders (customer_id, order_status, payment_status)
VALUES (3, 'Delivered', 'Paid');

-- ORDER_ITEMS
INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal)
VALUES (1, 1, 2, 650, 1300);
INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal)
VALUES (2, 3, 1, 900, 900);
INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal)
VALUES (3, 2, 1, 1200, 1200);

-- PAYMENTS
INSERT INTO payments (order_id, amount, payment_mode)
VALUES (2, 900, 'Card');
INSERT INTO payments (order_id, amount, payment_mode)
VALUES (3, 1200, 'UPI');

COMMIT;
/
