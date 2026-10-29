-- 02_triggers.sql
-- Inventory and Sales: business logic triggers
-- Requires 01_tables.sql. In SQL Workshop > SQL Commands run each trigger
-- separately (the "/" ends a PL/SQL block), or use SQL Scripts.

-- 1) Fill unit_price from the product when it was not entered
CREATE OR REPLACE TRIGGER order_items_price_trg
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
  IF :NEW.unit_price IS NULL THEN
    SELECT price
      INTO :NEW.unit_price
      FROM products
     WHERE product_id = :NEW.product_id;
  END IF;
END;
/

-- 2) Keep products.stock_qty in sync with order items
CREATE OR REPLACE TRIGGER order_items_stock_trg
AFTER INSERT OR UPDATE OR DELETE ON order_items
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    UPDATE products
       SET stock_qty = stock_qty - :NEW.quantity
     WHERE product_id = :NEW.product_id;
  ELSIF UPDATING THEN
    -- give back the old quantity, then take the new one
    UPDATE products
       SET stock_qty = stock_qty + :OLD.quantity
     WHERE product_id = :OLD.product_id;
    UPDATE products
       SET stock_qty = stock_qty - :NEW.quantity
     WHERE product_id = :NEW.product_id;
  ELSIF DELETING THEN
    UPDATE products
       SET stock_qty = stock_qty + :OLD.quantity
     WHERE product_id = :OLD.product_id;
  END IF;
END;
/
