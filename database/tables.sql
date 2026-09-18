-- Customer

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
-- Menu Category

CREATE TABLE Menu_category (
    category_id     NUMBER,-- GENERATED ALWAYS AS IDENTITY
    category_name   VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_menu_category PRIMARY KEY (category_id),
    CONSTRAINT uq_category_name UNIQUE (category_name)
);
-- Ingredient

CREATE TABLE Ingredient (
    ingredient_id   NUMBER ,--GENERATED ALWAYS AS IDENTITY
    name            VARCHAR2(100) NOT NULL,
    unit            VARCHAR2(20) NOT NULL,
    qty_in_stock    NUMBER(10,2) DEFAULT 0,
    CONSTRAINT pk_ingredient PRIMARY KEY (ingredient_id),
    CONSTRAINT chk_qty_in_stock CHECK (qty_in_stock >= 0)
);
-- Supplier

CREATE TABLE Supplier (
    supplier_id     NUMBER ,--GENERATED ALWAYS AS IDENTITY
    name            VARCHAR2(100) NOT NULL,
    contact_person  VARCHAR2(100),
    phone           VARCHAR2(20),
    email           VARCHAR2(100) UNIQUE,
    address         VARCHAR2(200),
    CONSTRAINT pk_supplier PRIMARY KEY (supplier_id)
);
-- Menu Item

CREATE TABLE Menu_item (
    menu_item_id         NUMBER,-- GENERATED ALWAYS AS IDENTITY
    name            VARCHAR2(100) NOT NULL,
    category        VARCHAR2(50),
    price           NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_menu_item PRIMARY KEY (menu_item_id),
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
-- Order_item

CREATE TABLE Order_item (
    order_item_id   NUMBER,-- GENERATED ALWAYS AS IDENTITY
    order_id        NUMBER NOT NULL,
    menu_item_id    NUMBER NOT NULL,
    quantity        NUMBER NOT NULL,
    unit_price      NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_order_item PRIMARY KEY (order_item_id),
    CONSTRAINT fk_order_item_order FOREIGN KEY (order_id)
        REFERENCES orders (order_id) ON DELETE CASCADE,
    CONSTRAINT fk_order_item_menu_item FOREIGN KEY (menu_item_id)
        REFERENCES menu_item (menu_item_id),
    CONSTRAINT chk_quantity CHECK (quantity > 0),
    CONSTRAINT chk_unit_price CHECK (unit_price > 0)
);
--Menu_item_ingredient

CREATE TABLE Menu_item_ingredient (
    menu_item_id    NUMBER NOT NULL,
    ingredient_id   NUMBER NOT NULL,
    qty_required    NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_menu_item_ingredient PRIMARY KEY (menu_item_id, ingredient_id),
    CONSTRAINT fk_mii_menu_item FOREIGN KEY (menu_item_id)
        REFERENCES menu_item (menu_item_id) ON DELETE CASCADE,
    CONSTRAINT fk_mii_ingredient FOREIGN KEY (ingredient_id)
        REFERENCES ingredient (ingredient_id),
    CONSTRAINT chk_qty_required CHECK (qty_required > 0)
);
-- Purchase

CREATE TABLE Purchase (
    purchase_id     NUMBER, --GENERATED ALWAYS AS IDENTITY
    supplier_id     NUMBER NOT NULL,
    ingredient_id   NUMBER NOT NULL,
    quantity        NUMBER(10,2) NOT NULL,
    unit_cost       NUMBER(10,2) NOT NULL,
    purchase_date   DATE DEFAULT SYSDATE,
    CONSTRAINT pk_purchase PRIMARY KEY (purchase_id),
    CONSTRAINT fk_purchase_supplier FOREIGN KEY (supplier_id)
        REFERENCES supplier (supplier_id),
    CONSTRAINT fk_purchase_ingredient FOREIGN KEY (ingredient_id)
        REFERENCES ingredient (ingredient_id),
    CONSTRAINT chk_purchase_quantity CHECK (quantity > 0),
    CONSTRAINT chk_unit_cost CHECK (unit_cost > 0)
);
-- Payment

CREATE TABLE Payment (
    payment_id      NUMBER,-- GENERATED ALWAYS AS IDENTITY
    order_id        NUMBER NOT NULL,
    amount          NUMBER(10,2) NOT NULL,
    method          VARCHAR2(50) NOT NULL,
    status          VARCHAR2(50) DEFAULT 'Pending',
    paid_at         TIMESTAMP,
    CONSTRAINT pk_payment PRIMARY KEY (payment_id),
    CONSTRAINT fk_payment_order FOREIGN KEY (order_id)
        REFERENCES orders (order_id) ON DELETE CASCADE,
    CONSTRAINT chk_amount CHECK (amount > 0),
    CONSTRAINT chk_payment_method CHECK (method IN ('Cash', 'Card', 'Online')),
    CONSTRAINT chk_payment_status CHECK (status IN ('Pending', 'Completed', 'Failed'))
);
-- Logs

CREATE TABLE Logs (
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

