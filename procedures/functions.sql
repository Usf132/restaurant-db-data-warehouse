CREATE OR REPLACE FUNCTION CalculateOrderTotal (
    p_order_id IN NUMBER
)
RETURN NUMBER
IS
    v_total NUMBER(10,2);
BEGIN
    SELECT NVL(SUM(quantity * unit_price), 0)
    INTO v_total
    FROM Order_item
    WHERE order_id = p_order_id;

    RETURN v_total;
END;
/

CREATE OR REPLACE FUNCTION GetCustomerVisitCount (
    p_customer_id IN NUMBER
)
RETURN NUMBER
IS
    v_visit_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_visit_count
    FROM Orders
    WHERE customer_id = p_customer_id
      AND status IN ('OPEN', 'CLOSED');

    RETURN v_visit_count;
END;
/
