-- 04_sample_data.sql
-- Inventory and Sales: demo data (fictional)
-- Requires 01 and 02. Plain INSERT statements are used on purpose
-- (INSERT ALL does not work well with identity columns).

INSERT INTO product_categories (category_name) VALUES ('Electronics');
INSERT INTO product_categories (category_name) VALUES ('Accessories');
INSERT INTO product_categories (category_name) VALUES ('Office');

INSERT INTO products (category_id, product_name, price, stock_qty, reorder_level)
VALUES ((SELECT category_id FROM product_categories WHERE category_name = 'Electronics'), 'Laptop', 650, 10, 5);
INSERT INTO products (category_id, product_name, price, stock_qty, reorder_level)
VALUES ((SELECT category_id FROM product_categories WHERE category_name = 'Electronics'), 'Phone', 400, 15, 5);
INSERT INTO products (category_id, product_name, price, stock_qty, reorder_level)
VALUES ((SELECT category_id FROM product_categories WHERE category_name = 'Accessories'), 'Headphones', 35, 40, 5);
INSERT INTO products (category_id, product_name, price, stock_qty, reorder_level)
VALUES ((SELECT category_id FROM product_categories WHERE category_name = 'Accessories'), 'Mouse', 12, 50, 5);
INSERT INTO products (category_id, product_name, price, stock_qty, reorder_level)
VALUES ((SELECT category_id FROM product_categories WHERE category_name = 'Accessories'), 'Keyboard', 25, 30, 5);
INSERT INTO products (category_id, product_name, price, stock_qty, reorder_level)
VALUES ((SELECT category_id FROM product_categories WHERE category_name = 'Accessories'), 'USB Cable', 4, 100, 5);
INSERT INTO products (category_id, product_name, price, stock_qty, reorder_level)
VALUES ((SELECT category_id FROM product_categories WHERE category_name = 'Office'), 'Notebook', 2.5, 80, 5);
INSERT INTO products (category_id, product_name, price, stock_qty, reorder_level)
VALUES ((SELECT category_id FROM product_categories WHERE category_name = 'Office'), 'Pen Pack', 3, 60, 5);
INSERT INTO products (category_id, product_name, price, stock_qty, reorder_level)
VALUES ((SELECT category_id FROM product_categories WHERE category_name = 'Office'), 'Desk Lamp', 18, 4, 5);

INSERT INTO customers (customer_name, phone, city) VALUES ('Customer One',   '0790000001', 'Amman');
INSERT INTO customers (customer_name, phone, city) VALUES ('Customer Two',   '0790000002', 'Irbid');
INSERT INTO customers (customer_name, phone, city) VALUES ('Customer Three', '0790000003', 'Zarqa');
INSERT INTO customers (customer_name, phone, city) VALUES ('Customer Four',  '0790000004', 'Aqaba');

COMMIT;
