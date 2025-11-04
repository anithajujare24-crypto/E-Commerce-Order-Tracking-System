-- create_tables.sql
-- customers
create table customers (
    customer_id number generated always as identity primary key,
    customer_name varchar2(50),
    email varchar2(50),
    phone varchar2(15),
    city varchar2(30)
);

-- products
create table products (
  product_id number generated always as identity primary key,
  product_name varchar2(50),
  category varchar2(30),
  unit_price number(10,2),
  stock_qty number(10)
);

-- orders
create table orders (
  order_id number generated always as identity primary key,
  customer_id number,
  order_date date default sysdate,
  order_status varchar2(20),
  payment_status varchar2(20),
  foreign key (customer_id) references customers(customer_id)
);

-- order_items
create table order_items (
  order_item_id number generated always as identity primary key,
  order_id number,
  product_id number,
  quantity number,
  unit_price number(10,2),
  subtotal number(10,2),
  foreign key (order_id) references orders(order_id),
  foreign key (product_id) references products(product_id)
);

-- payments
create table payments (
  payment_id number generated always as identity primary key,
  order_id number,
  amount number(10,2),
  payment_mode varchar2(20),
  payment_date date default sysdate,
  foreign key (order_id) references orders(order_id)
);

-- order_audit_log
create table order_audit_log (
  log_id number generated always as identity primary key,
  order_id number,
  old_status varchar2(20),
  new_status varchar2(20),
  changed_by varchar2(50),
  changed_on date default sysdate,
  remarks varchar2(120),
  foreign key (order_id) references orders(order_id)
);
/
commit;