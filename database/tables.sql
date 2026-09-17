-- Customer 
CREATE TABLE customer (
    customer_id     NUMBER ,
    name            VARCHAR2(100) UNIQUE,
    phone           VARCHAR2(20),
    email           VARCHAR2(100),
    address         VARCHAR2(200),
    CONSTRAINT pk_customer PRIMARY KEY (customer_id)
);
-- Restaurant_table

CREATE TABLE restaurant_table (
    table_id        NUMBER ,
    table_number    NUMBER,
    capacity        NUMBER,
    location        VARCHAR2(100),
    CONSTRAINT pk_restaurant_table PRIMARY KEY (table_id)
);
-- Employee

CREATE TABLE employee (
    employee_id     NUMBER ,
    name            VARCHAR2(100),
    role            VARCHAR2(50),
    phone           VARCHAR2(20),
    email           VARCHAR2(100),
    hire_date       DATE,
    CONSTRAINT pk_employee PRIMARY KEY (employee_id)
);
-- Menu_category

CREATE TABLE menu_category (
    category_id     NUMBER,
    category_name   VARCHAR2(100),
    CONSTRAINT pk_menu_category PRIMARY KEY (category_id)
);
-- Ingredient

CREATE TABLE ingredient (
    ingredient_id   NUMBER,
    name            VARCHAR2(100),
    unit            VARCHAR2(20),
    qty_in_stock    NUMBER(10,2),
    CONSTRAINT pk_ingredient PRIMARY KEY (ingredient_id)
);
-- Supplier

CREATE TABLE supplier (
    supplier_id    NUMBER ,
    name            VARCHAR2(100),
    contact_person  VARCHAR2(100),
    phone           VARCHAR2(20),
    email           VARCHAR2(100),
    address         VARCHAR2(200),
    CONSTRAINT pk_supplier PRIMARY KEY (supplier_id)
);
-- Reservation

CREATE TABLE reservation (
    reservation_id NUMBER,
    customer_id     NUMBER NOT NULL,
    table_id        NUMBER NOT NULL,
    res_date        DATE,
    res_time        DATE,          
    party_size      NUMBER,
    status          VARCHAR2(30),
    CONSTRAINT pk_reservation PRIMARY KEY (reservation_id),
    CONSTRAINT fk_reservation_customer FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id),
    CONSTRAINT fk_reservation_table FOREIGN KEY (table_id)
        REFERENCES restaurant_table (table_id)
);
-- Orders

CREATE TABLE orders (
    order_id        NUMBER,
    customer_id     NUMBER,
    table_id        NUMBER NOT NULL,
    employee_id     NUMBER NOT NULL,
    order_time      TIMESTAMP,
    status          VARCHAR2(30),
    CONSTRAINT pk_orders PRIMARY KEY (order_id),
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id),
    CONSTRAINT fk_orders_table FOREIGN KEY (table_id)
        REFERENCES restaurant_table (table_id),
    CONSTRAINT fk_orders_employee FOREIGN KEY (employee_id)
        REFERENCES employee (employee_id)
);
-- Menu_item

CREATE TABLE menu_item (
    menu_item_id    NUMBER,
    name            VARCHAR2(100),
    description     VARCHAR2(500),
    category_id     NUMBER NOT NULL,
    price           NUMBER(10,2),
    availability    NUMBER(1) DEFAULT 1 CHECK (availability IN (0,1)),  -- boolean substitute
    CONSTRAINT pk_menu_item PRIMARY KEY (menu_item_id),
    CONSTRAINT fk_menu_item_category FOREIGN KEY (category_id)
        REFERENCES menu_category (category_id)
);
-- Payment

CREATE TABLE payment (
    payment_id      NUMBER ,
    order_id        NUMBER NOT NULL,
    amount          NUMBER(10,2),
    method          VARCHAR2(50),
    status          VARCHAR2(50),
    paid_at         TIMESTAMP,
    CONSTRAINT pk_payment PRIMARY KEY (payment_id),
    CONSTRAINT fk_payment_order FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
);
-- Order_item

CREATE TABLE order_item (
    order_item_id   NUMBER ,
    order_id        NUMBER NOT NULL,
    menu_item_id    NUMBER NOT NULL,
    quantity        NUMBER,
    unit_price      NUMBER(10,2),
    CONSTRAINT pk_order_item PRIMARY KEY (order_item_id),
    CONSTRAINT fk_order_item_order FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    CONSTRAINT fk_order_item_menu_item FOREIGN KEY (menu_item_id)
        REFERENCES menu_item (menu_item_id)
);
-- Menu_item_ingredient (composite PK)

CREATE TABLE menu_item_ingredient (
    menu_item_id    NUMBER NOT NULL,
    ingredient_id   NUMBER NOT NULL,
    qty_required    NUMBER(10,2),
    CONSTRAINT pk_menu_item_ingredient PRIMARY KEY (menu_item_id, ingredient_id),
    CONSTRAINT fk_mii_menu_item FOREIGN KEY (menu_item_id)
        REFERENCES menu_item (menu_item_id),
    CONSTRAINT fk_mii_ingredient FOREIGN KEY (ingredient_id)
        REFERENCES ingredient (ingredient_id)
);
-- Purchase

CREATE TABLE purchase (
    purchase_id     NUMBER ,
    supplier_id     NUMBER NOT NULL,
    ingredient_id   NUMBER NOT NULL,
    quantity        NUMBER(10,2),
    unit_cost       NUMBER(10,2),
    purchase_date   DATE,
    CONSTRAINT pk_purchase PRIMARY KEY (purchase_id),
    CONSTRAINT fk_purchase_supplier FOREIGN KEY (supplier_id)
        REFERENCES supplier (supplier_id),
    CONSTRAINT fk_purchase_ingredient FOREIGN KEY (ingredient_id)
        REFERENCES ingredient (ingredient_id)
);
-- Logs
CREATE TABLE logs (
    log_id          NUMBER ,
    employee_id     NUMBER,
    action_type     VARCHAR2(50),
    table_name      VARCHAR2(100),
    record_id       NUMBER,
    action_details  VARCHAR2(500),
    log_date        DATE DEFAULT SYSDATE,
    CONSTRAINT pk_logs PRIMARY KEY (log_id),
    CONSTRAINT fk_logs_employee FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);
