-- 03_views.sql
-- Inventory and Sales: views used by the catalog, reports and dashboard
-- Requires 01_tables.sql.

CREATE OR REPLACE VIEW products_v AS
SELECT p.product_id,
       p.product_name,
       c.category_name,
       p.price,
       p.stock_qty,
       p.reorder_level,
       CASE WHEN p.stock_qty <= p.reorder_level THEN 'Low' ELSE 'OK' END AS stock_status,
       CASE WHEN p.price < 10 THEN 'Under 10'
            WHEN p.price < 50 THEN '10 - 50'
            ELSE 'Over 50' END AS price_range
  FROM products p
  JOIN product_categories c ON c.category_id = p.category_id;

CREATE OR REPLACE VIEW order_totals_v AS
SELECT o.order_id,
       c.customer_name,
       o.order_date,
       o.status,
       COUNT(i.item_id) AS items_count,
       NVL(SUM(i.quantity * i.unit_price), 0) AS total_amount
  FROM orders o
  LEFT JOIN customers c   ON c.customer_id = o.customer_id
  LEFT JOIN order_items i ON i.order_id = o.order_id
 GROUP BY o.order_id, c.customer_name, o.order_date, o.status;
