-- =====================================================================
-- Script Name     :  schema.sql
-- Project         :  E-Commerce Order Tracking System
-- Author          :  J. Anitha
-- Purpose         :  Defines database schema (tables and relationships)
-- =====================================================================

--
-- =====================================================================
-- Table          :  customers
-- Stores customer personal details and contact information
-- =====================================================================

create table customers (
    customer_id number generated always as identity primary key,-- Unique ID for each customer
    customer_name varchar2(50),
    email varchar2(50),
    phone varchar2(15),
    city varchar2(30)
);

--
-- =====================================================================
-- Table          :  products
-- Contains all product details available in the store
-- =====================================================================

create table products (
  product_id number generated always as identity primary key,-- Unique ID for each product
  product_name varchar2(50),
  category varchar2(30),
  unit_price number(10,2),
  stock_qty number(10)
);

--
-- ======================================================================
-- Table          :  orders
-- Tracks orders placed by customers and their payment status
-- ======================================================================

create table orders (
  order_id number generated always as identity primary key,-- Unique ID for each order
  customer_id number,
  order_date date default sysdate,
  order_status varchar2(20),
  payment_status varchar2(20),
  foreign key (customer_id) references customers(customer_id)-- Ensures order is linked to the valid customer
);

--
-- =======================================================================
-- Table          :  order_items
-- Stores detailed information about each product within an order
-- =======================================================================

create table order_items (
  order_item_id number generated always as identity primary key,-- Unique ID for each order item entry
  order_id number,
  product_id number,
  quantity number,
  unit_price number(10,2),
  subtotal number(10,2),
  foreign key (order_id) references orders(order_id),-- Ensures link to valid order record
  foreign key (product_id) references products(product_id)-- Ensures link to valid product record
);

--
-- =====================================================================
-- Table           :  Payments
-- Stores all payment transactions related to orders
-- =====================================================================

create table payments (
  payment_id number generated always as identity primary key,
  order_id number,
  amount number(10,2),
  payment_mode varchar2(20),
  payment_date date default sysdate,
  foreign key (order_id) references orders(order_id)-- Ensures payment belongs to a valid order
);

--
-- ======================================================================
-- Table            :  order_audit_log
-- Keeps a history of order status changes for tracking and auditing
-- ======================================================================

create table order_audit_log (
  log_id number generated always as identity primary key,-- Unique ID for each audit entry
  order_id number,
  old_status varchar2(20),
  new_status varchar2(20),
  changed_by varchar2(50),
  changed_on date default sysdate,
  remarks varchar2(120),
  foreign key (order_id) references orders(order_id)-- Ensures valid reference to existing order
);
/
commit;
