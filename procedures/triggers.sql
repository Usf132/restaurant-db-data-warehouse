--------------------------------------------------------------------------------
-- Restaurant Database - Triggers
-- Part 6: Triggers (at least 2 required; 3 provided)
--------------------------------------------------------------------------------

-- Sequence for Logs.log_id (starts above the seeded rows)
CREATE SEQUENCE seq_logs START WITH 100;

--------------------------------------------------------------------------------
-- 1) TRG_INVENTORY_UPDATE
-- Deduct ingredients when an order line is added
--------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_inventory_update
AFTER INSERT ON Order_item
FOR EACH ROW
DECLARE
    v_stock NUMBER;
BEGIN
    FOR r IN (
        SELECT ingredient_id, qty_required
        FROM Menu_item_ingredient
        WHERE menu_item_id = :NEW.menu_item_id
    ) LOOP
        SELECT qty_in_stock INTO v_stock
        FROM Ingredient
        WHERE ingredient_id = r.ingredient_id
        FOR UPDATE;

        IF v_stock < r.qty_required * :NEW.quantity THEN
            RAISE_APPLICATION_ERROR(-20005, 'Not enough stock for ingredient ' || r.ingredient_id);
        END IF;

        UPDATE Ingredient
        SET qty_in_stock = qty_in_stock - r.qty_required * :NEW.quantity
        WHERE ingredient_id = r.ingredient_id;
    END LOOP;
END;
/

--------------------------------------------------------------------------------
-- 2) TRG_PRICE_AUDIT
-- Log price changes in the Logs table
--------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_price_audit
AFTER UPDATE OF price ON Menu_item
FOR EACH ROW
WHEN (NEW.price <> OLD.price)
BEGIN
    INSERT INTO Logs (
        log_id, action_type, table_name, record_id, action_details
    )
    VALUES (
        seq_logs.NEXTVAL,
        'PRICE_CHANGE',
        'MENU_ITEM',
        :OLD.menu_item_id,
        'Price ' || :OLD.price || ' -> ' || :NEW.price || ' by ' || USER
    );
END;
/

--------------------------------------------------------------------------------
-- 3) TRG_ORDER_TOTAL
-- Add the new line amount and subtract the old line amount
--------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_order_total
AFTER INSERT OR UPDATE OR DELETE ON Order_item
FOR EACH ROW
BEGIN
    UPDATE Orders
    SET total_amount = NVL(total_amount, 0)
                     + NVL(:NEW.quantity * :NEW.unit_price, 0)
                     - NVL(:OLD.quantity * :OLD.unit_price, 0)
    WHERE order_id = NVL(:NEW.order_id, :OLD.order_id);
END;
/
