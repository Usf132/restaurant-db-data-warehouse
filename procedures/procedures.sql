--------------------------------------------------------------------------------
-- GetCustomerOrders
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE GetCustomerOrders (
    p_customer_id IN Customer.customer_id%TYPE,
    p_orders      OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_orders FOR
        SELECT order_id, customer_id, employee_id, table_id,
               order_date, status, total_amount
        FROM Orders
        WHERE customer_id = p_customer_id
        ORDER BY order_date DESC;
END;
/


--------------------------------------------------------------------------------
-- CreateReservation
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE CreateReservation (
    p_customer_id       IN Reservation.customer_id%TYPE,
    p_table_id          IN Reservation.table_id%TYPE,
    p_reservation_start IN Reservation.reservation_start%TYPE,
    p_duration_minutes  IN Reservation.duration_minutes%TYPE,
    p_number_of_guests  IN Reservation.number_of_guests%TYPE
)
AS
    v_count    NUMBER;
    v_capacity NUMBER;
BEGIN
    -- FOR UPDATE locks the table row so two bookings can't overlap
    SELECT capacity
    INTO v_capacity
    FROM Restaurant_table
    WHERE table_id = p_table_id
    FOR UPDATE;

    IF p_number_of_guests > v_capacity THEN
        RAISE_APPLICATION_ERROR(-20001, 'Number of guests exceeds table capacity');
    END IF;

    SELECT COUNT(*)
    INTO v_count
    FROM Reservation
    WHERE table_id = p_table_id
      AND status = 'CONFIRMED'
      AND p_reservation_start 
          reservation_start + NUMTODSINTERVAL(duration_minutes, 'MINUTE')
      AND p_reservation_start +
          NUMTODSINTERVAL(p_duration_minutes, 'MINUTE') > reservation_start;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Table is already reserved');
    END IF;

    INSERT INTO Reservation (
        customer_id, table_id, reservation_start,
        duration_minutes, number_of_guests, status
    )
    VALUES (
        p_customer_id, p_table_id, p_reservation_start,
        p_duration_minutes, p_number_of_guests, 'CONFIRMED'
    );
END;
/


--------------------------------------------------------------------------------
-- ProcessPayment
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ProcessPayment (
    p_order_id IN Payment.order_id%TYPE,
    p_amount   IN Payment.amount%TYPE,
    p_method   IN Payment.method%TYPE
)
AS
    v_total_amount NUMBER;
    v_status       Orders.status%TYPE;
    v_paid_amount  NUMBER;
BEGIN
    -- FOR UPDATE locks the order so concurrent payments can't both pass the check
    SELECT total_amount, status
    INTO v_total_amount, v_status
    FROM Orders
    WHERE order_id = p_order_id
    FOR UPDATE;

    IF v_status <> 'OPEN' THEN
        RAISE_APPLICATION_ERROR(-20004, 'Order is not open');
    END IF;

    SELECT NVL(SUM(amount), 0)
    INTO v_paid_amount
    FROM Payment
    WHERE order_id = p_order_id
      AND status = 'COMPLETED';

    IF v_paid_amount + p_amount > v_total_amount THEN
        RAISE_APPLICATION_ERROR(-20003, 'Payment exceeds remaining balance');
    END IF;

    INSERT INTO Payment (order_id, amount, method, status, paid_at)
    VALUES (p_order_id, p_amount, UPPER(p_method), 'COMPLETED', SYSTIMESTAMP);

    IF v_paid_amount + p_amount = v_total_amount THEN
        UPDATE Orders
        SET status = 'CLOSED'
        WHERE order_id = p_order_id;
    END IF;
END;
/
