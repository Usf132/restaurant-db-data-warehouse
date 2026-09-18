--------------------------------------------------------------------------------
-- Restaurant Database - Triggers 
-- Part 6: Triggers (at least 2 required; 3 provided)
--------------------------------------------------------------------------------
-- Sequence for Logs.log_id 
CREATE SEQUENCE seq_logs;

--------------------------------------------------------------------------------
-- 1) TRG_INVENTORY_UPDATE
-- Deduct ingredients when an order line is added
CREATE OR REPLACE TRIGGER trg_inventory_update
AFTER INSERT ON Order_item
FOR EACH ROW
BEGIN
    FOR r IN (SELECT ingredient_id, qty_required
              FROM Menu_item_ingredient
              WHERE menu_item_id = :NEW.menu_item_id)
    LOOP
        UPDATE Ingredient
        SET qty_in_stock = qty_in_stock - r.qty_required * :NEW.quantity
        WHERE ingredient_id = r.ingredient_id;
    END LOOP;
END;
/
  
--------------------------------------------------------------------------------
-- 2) TRG_PRICE_AUDIT
-- Log price changes
CREATE OR REPLACE TRIGGER trg_price_audit
AFTER UPDATE OF price ON Menu_item
FOR EACH ROW
WHEN (NEW.price <> OLD.price)
BEGIN
    INSERT INTO Logs (log_id, action_type, table_name, record_id, action_details)
    VALUES (seq_logs.NEXTVAL, 'PRICE_CHANGE', 'MENU_ITEM', :OLD.menu_item_id,
            'Price ' || :OLD.price || ' -> ' || :NEW.price || ' by ' || USER);
END;
/
  
--------------------------------------------------------------------------------
-- 3) TRG_ORDER_TOTAL (bonus)
-- add new line amount, subtract old one
CREATE OR REPLACE TRIGGER trg_order_total
AFTER INSERT OR UPDATE OR DELETE ON Order_item
FOR EACH ROW
BEGIN
    UPDATE Orders
    SET TotalAmount = TotalAmount
                      + NVL(:NEW.quantity * :NEW.unit_price, 0)
                      - NVL(:OLD.quantity * :OLD.unit_price, 0)
    WHERE order_id = NVL(:NEW.order_id, :OLD.order_id);
END;
/
