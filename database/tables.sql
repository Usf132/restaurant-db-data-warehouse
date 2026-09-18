CREATE TABLE Customer (
    customer_id     NUMBER, --GENERATED ALWAYS AS IDENTITY
    name            VARCHAR2(100) NOT NULL,
    phone           VARCHAR2(20),
    email           VARCHAR2(100) UNIQUE,
    address         VARCHAR2(200),
    CONSTRAINT pk_customer PRIMARY KEY (customer_id)
);
-- Restaurant Table

CREATE TABLE Restaurant_table (
    table_id        NUMBER,-- GENERATED ALWAYS AS IDENTITY
    table_number    NUMBER NOT NULL,
    capacity        NUMBER NOT NULL,
    location        VARCHAR2(100),
    CONSTRAINT pk_restaurant_table PRIMARY KEY (table_id),
    CONSTRAINT uq_table_number UNIQUE (table_number),
    CONSTRAINT chk_capacity CHECK (capacity > 0)
);
-- Employee

CREATE TABLE Employee (
    employee_id     NUMBER,-- GENERATED ALWAYS AS IDENTITY
    name            VARCHAR2(100) NOT NULL,
    phone           VARCHAR2(20),
    email           VARCHAR2(100) UNIQUE,
    position        VARCHAR2(50),
    hire_date       DATE DEFAULT SYSDATE,
    salary          NUMBER(10,2),
    CONSTRAINT pk_employee PRIMARY KEY (employee_id),
    CONSTRAINT chk_salary CHECK (salary > 0)
);
-- Menu Item

CREATE TABLE Menu_item (
    item_id         NUMBER,-- GENERATED ALWAYS AS IDENTITY
    name            VARCHAR2(100) NOT NULL,
    category        VARCHAR2(50),
    price           NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_menu_item PRIMARY KEY (item_id),
    CONSTRAINT chk_price CHECK (price > 0)
);
-- Reservation

CREATE TABLE Reservation (
    reservation_id      NUMBER ,--GENERATED ALWAYS AS IDENTITY
    customer_id         NUMBER NOT NULL,
    table_id            NUMBER NOT NULL,
    reservation_date    DATE NOT NULL,
    reservation_time    VARCHAR2(10) NOT NULL,
    number_of_guests    NUMBER NOT NULL,
    status              VARCHAR2(20) DEFAULT 'CONFIRMED',
    CONSTRAINT pk_reservation PRIMARY KEY (reservation_id),
    CONSTRAINT fk_res_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_res_table FOREIGN KEY (table_id) REFERENCES restaurant_table(table_id),
    CONSTRAINT chk_guests CHECK (number_of_guests > 0 AND number_of_guests <= 20),
    CONSTRAINT chk_reservation_status CHECK (status IN ('CONFIRMED', 'CANCELLED', 'COMPLETED'))
);
-- Orders

CREATE TABLE Orders (
    order_id        NUMBER,-- GENERATED ALWAYS AS IDENTITY
    customer_id     NUMBER NOT NULL,
    employee_id     NUMBER NOT NULL,
    table_id        NUMBER NOT NULL,
    order_date      DATE DEFAULT SYSDATE,
    status          VARCHAR2(20) DEFAULT 'OPEN',
    CONSTRAINT pk_orders PRIMARY KEY (order_id),
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    CONSTRAINT fk_orders_employee FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    CONSTRAINT fk_orders_table FOREIGN KEY (table_id) REFERENCES restaurant_table(table_id),
    CONSTRAINT chk_order_status CHECK (status IN ('OPEN', 'CLOSED', 'CANCELLED'))
);
-- Order Details

CREATE TABLE Order_details (
    order_detail_id NUMBER,-- GENERATED ALWAYS AS IDENTITY
    order_id        NUMBER NOT NULL,
    item_id         NUMBER NOT NULL,
    quantity        NUMBER NOT NULL,
    unit_price      NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_order_details PRIMARY KEY (order_detail_id),
    CONSTRAINT fk_od_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_od_item FOREIGN KEY (item_id) REFERENCES menu_item(item_id),
    CONSTRAINT chk_quantity CHECK (quantity > 0)
);
-- Logs

CREATE TABLE logs (
    log_id          NUMBER,-- GENERATED ALWAYS AS IDENTITY
    employee_id     NUMBER,
    action_type     VARCHAR2(50),
    table_name      VARCHAR2(100),
    record_id       NUMBER,
    action_details  VARCHAR2(500),
    log_date        DATE DEFAULT SYSDATE,
    CONSTRAINT pk_logs PRIMARY KEY (log_id),
    CONSTRAINT fk_logs_employee FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);
