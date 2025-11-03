CREATE OR REPLACE VIEW v_pending_deliveries AS
SELECT
  o.order_id,
  c.customer_name,
  o.order_status,
  o.payment_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status NOT IN ('Delivered');
/
