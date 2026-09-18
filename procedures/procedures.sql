--GetCustomerOrders

CREATE OR REPLACE PROCEDURE GetCustomerOrders (
    p_customer_id IN Customer.Customer_ID%TYPE,
    p_orders OUT SYS_REFCURSOR
)
AS
BEGIN

    OPEN p_orders FOR
        SELECT
            o.order_ID,
            o.Customer_ID,
            o.table_ID,
            o.Emp_D,
            o.order_date,
            o.order_Time,
            o.order_statue
        FROM Customer_Order o
        WHERE o.Customer_ID = p_customer_id
        ORDER BY o.order_date DESC, o.order_Time DESC;

END;



VARIABLE rc REFCURSOR;

EXEC GetCustomerOrders(1, :rc);

PRINT rc;


--CreateReservation



CREATE OR REPLACE PROCEDURE CreateReservation (
    p_customer_id IN Reservation.Customer_ID%TYPE,
    p_table_id    IN Reservation.Table_D%TYPE,
    p_reser_date  IN Reservation.Reser_Date%TYPE,
    p_reser_time  IN Reservation.Reser_Time%TYPE
)
AS
    v_count NUMBER;
BEGIN

    -- Check if table exists
    SELECT COUNT(*)
    INTO v_count
    FROM Reservation_table
    WHERE table_id = p_table_id;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Table does not exist'
        );
    END IF;


    -- Check if table is already reserved
    SELECT COUNT(*)
    INTO v_count
    FROM Reservation
    WHERE Table_D = p_table_id
      AND Reser_Date = p_reser_date
      AND Reser_Time = p_reser_time
      AND Statue = 'CONFIRMED';

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Table is already reserved'
        );
    END IF;


    -- Create reservation
    INSERT INTO Reservation (
        Reser_D,
        Customer_ID,
        Table_D,
        Reser_Date,
        Reser_Time,
        Statue
    )
    VALUES (
        Reservation_SEQ.NEXTVAL,
        p_customer_id,
        p_table_id,
        p_reser_date,
        p_reser_time,
        'CONFIRMED'
    );

END;


--ProcessPayment



CREATE OR REPLACE PROCEDURE ProcessPayment (
    p_order_id IN Payment.order_ID%TYPE,
    p_amount   IN Payment.amount_ID%TYPE,
    p_method   IN Payment.method%TYPE
)
AS
    v_order_total NUMBER;
    v_paid_total  NUMBER;
BEGIN

    -- Calculate order total
    SELECT NVL(SUM(quantati * unit_price), 0)
    INTO v_order_total
    FROM Order_item
    WHERE order_ID = p_order_id;


    -- Check order
    IF v_order_total = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            'Order does not exist or has no items'
        );
    END IF;


    -- Calculate previous payments
    SELECT NVL(SUM(amount_ID), 0)
    INTO v_paid_total
    FROM Payment
    WHERE order_ID = p_order_id
      AND pay_statue = 'PAID';


    -- Prevent overpayment
    IF v_paid_total + p_amount > v_order_total THEN
        RAISE_APPLICATION_ERROR(
            -20004,
            'Payment exceeds order total'
        );
    END IF;


    -- Insert payment
    INSERT INTO Payment (
        pay_D,
        order_ID,
        amount_ID,
        pay_statue,
        pay_date,
        method
    )
    VALUES (
        Payment_SEQ.NEXTVAL,
        p_order_id,
        p_amount,
        'PAID',
        SYSDATE,
        p_method
    );


    -- If fully paid
    IF v_paid_total + p_amount = v_order_total THEN

        UPDATE Customer_Order
        SET order_statue = 'PAID'
        WHERE order_ID = p_order_id;

    END IF;

END;
