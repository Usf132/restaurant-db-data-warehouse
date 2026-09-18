--------------------------------------------------------------------------------
-- Customer
--------------------------------------------------------------------------------
CREATE TABLE Customer (
    customer_id     NUMBER GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR2(100) NOT NULL,
    phone           VARCHAR2(20),
    email           VARCHAR2(100),
    address         VARCHAR2(200),
    is_active       NUMBER(1) DEFAULT 1 NOT NULL,
    CONSTRAINT pk_customer        PRIMARY KEY (customer_id),
    CONSTRAINT uq_customer_email  UNIQUE (email),
    CONSTRAINT chk_customer_active CHECK (is_active IN (0, 1))
);

--------------------------------------------------------------------------------
-- Restaurant_table
--------------------------------------------------------------------------------
CREATE TABLE Restaurant_table (
    table_id        NUMBER GENERATED ALWAYS AS IDENTITY,
    table_number    NUMBER NOT NULL,
    capacity        NUMBER NOT NULL,
    location        VARCHAR2(100),
    CONSTRAINT pk_restaurant_table PRIMARY KEY (table_id),
    CONSTRAINT uq_table_number     UNIQUE (table_number),
    CONSTRAINT chk_capacity        CHECK (capacity > 0)
);

--------------------------------------------------------------------------------
-- Employee
--------------------------------------------------------------------------------
CREATE TABLE Employee (
    employee_id     NUMBER GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR2(100) NOT NULL,
    phone           VARCHAR2(20),
    email           VARCHAR2(100),
    position        VARCHAR2(50),
    hire_date       DATE DEFAULT SYSDATE,
    salary          NUMBER(10,2),
    is_active       NUMBER(1) DEFAULT 1 NOT NULL,
    CONSTRAINT pk_employee        PRIMARY KEY (employee_id),
    CONSTRAINT uq_employee_email  UNIQUE (email),
    CONSTRAINT chk_salary         CHECK (salary > 0),
    CONSTRAINT chk_employee_active CHECK (is_active IN (0, 1))
);

--------------------------------------------------------------------------------
-- Menu_category
--------------------------------------------------------------------------------
CREATE TABLE Menu_category (
    category_id     NUMBER GENERATED ALWAYS AS IDENTITY,
    category_name   VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_menu_category PRIMARY KEY (category_id),
    CONSTRAINT uq_category_name UNIQUE (category_name)
);

--------------------------------------------------------------------------------
-- Ingredient
--------------------------------------------------------------------------------
CREATE TABLE Ingredient (
    ingredient_id   NUMBER GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR2(100) NOT NULL,
    unit            VARCHAR2(20) NOT NULL,
    qty_in_stock    NUMBER(10,2) DEFAULT 0 NOT NULL,
    CONSTRAINT pk_ingredient      PRIMARY KEY (ingredient_id),
    CONSTRAINT uq_ingredient_name UNIQUE (name),
    CONSTRAINT chk_qty_in_stock   CHECK (qty_in_stock >= 0)
);

--------------------------------------------------------------------------------
-- Supplier
--------------------------------------------------------------------------------
CREATE TABLE Supplier (
    supplier_id     NUMBER GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR2(100) NOT NULL,
    contact_person  VARCHAR2(100),
    phone           VARCHAR2(20),
    email           VARCHAR2(100),
    address         VARCHAR2(200),
    CONSTRAINT pk_supplier       PRIMARY KEY (supplier_id),
    CONSTRAINT uq_supplier_email UNIQUE (email)
);

--------------------------------------------------------------------------------
-- Menu_item  (category is now a real foreign key to Menu_category)
--------------------------------------------------------------------------------
CREATE TABLE Menu_item (
    menu_item_id    NUMBER GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR2(100) NOT NULL,
    category_id     NUMBER NOT NULL,
    price           NUMBER(10,2) NOT NULL,
    is_active       NUMBER(1) DEFAULT 1 NOT NULL,
    CONSTRAINT pk_menu_item          PRIMARY KEY (menu_item_id),
    CONSTRAINT uq_menu_item_name     UNIQUE (name),
    CONSTRAINT fk_menu_item_category FOREIGN KEY (category_id) REFERENCES Menu_category (category_id),
    CONSTRAINT chk_price             CHECK (price > 0),
    CONSTRAINT chk_menu_item_active  CHECK (is_active IN (0, 1))
);

--------------------------------------------------------------------------------
-- Reservation
--   reservation_start is a single TIMESTAMP (replaces the old DATE + VARCHAR2
--   time pair) so overlap checks are exact. The guest limit is the table's
--   capacity, enforced by trg_reservation_capacity and CreateReservation.
--------------------------------------------------------------------------------
CREATE TABLE Reservation (
    reservation_id      NUMBER GENERATED ALWAYS AS IDENTITY,
    customer_id         NUMBER NOT NULL,
    table_id            NUMBER NOT NULL,
    reservation_start   TIMESTAMP NOT NULL,
    duration_minutes    NUMBER(4) DEFAULT 90 NOT NULL,
    number_of_guests    NUMBER(3) NOT NULL,
    status              VARCHAR2(20) DEFAULT 'CONFIRMED' NOT NULL,
    CONSTRAINT pk_reservation        PRIMARY KEY (reservation_id),
    CONSTRAINT fk_res_customer       FOREIGN KEY (customer_id) REFERENCES Customer (customer_id),
    CONSTRAINT fk_res_table          FOREIGN KEY (table_id)    REFERENCES Restaurant_table (table_id),
    CONSTRAINT chk_guests            CHECK (number_of_guests > 0),
    CONSTRAINT chk_res_duration      CHECK (duration_minutes BETWEEN 15 AND 480),
    CONSTRAINT chk_reservation_status CHECK (status IN ('CONFIRMED', 'CANCELLED', 'COMPLETED'))
);

-- Database-level backstop against double booking: at most one CONFIRMED
-- reservation per table per start time. (Overlapping-but-different start times
-- are caught by CreateReservation, which locks the table row first.)
CREATE UNIQUE INDEX uq_res_active_slot ON Reservation (
    CASE WHEN status = 'CONFIRMED' THEN table_id END,
    CASE WHEN status = 'CONFIRMED' THEN reservation_start END
);

--------------------------------------------------------------------------------
-- Orders
--   customer_id is nullable so walk-in guests can be served.
--   total_amount is maintained by trg_order_total.
--------------------------------------------------------------------------------
CREATE TABLE Orders (
    order_id        NUMBER GENERATED ALWAYS AS IDENTITY,
    customer_id     NUMBER,
    employee_id     NUMBER NOT NULL,
    table_id        NUMBER NOT NULL,
    reservation_id  NUMBER,
    order_date      DATE DEFAULT SYSDATE NOT NULL,
    status          VARCHAR2(20) DEFAULT 'OPEN' NOT NULL,
    total_amount    NUMBER(10,2) DEFAULT 0 NOT NULL,
    CONSTRAINT pk_orders             PRIMARY KEY (order_id),
    CONSTRAINT fk_orders_customer    FOREIGN KEY (customer_id)    REFERENCES Customer (customer_id),
    CONSTRAINT fk_orders_employee    FOREIGN KEY (employee_id)    REFERENCES Employee (employee_id),
    CONSTRAINT fk_orders_table       FOREIGN KEY (table_id)       REFERENCES Restaurant_table (table_id),
    CONSTRAINT fk_orders_reservation FOREIGN KEY (reservation_id) REFERENCES Reservation (reservation_id),
    CONSTRAINT chk_order_status      CHECK (status IN ('OPEN', 'CLOSED', 'CANCELLED')),
    CONSTRAINT chk_order_total       CHECK (total_amount >= 0)
);

--------------------------------------------------------------------------------
-- Order_item
--   unit_price is a snapshot of the menu price at order time (filled
--   automatically by trg_order_item_before when omitted).
--------------------------------------------------------------------------------
CREATE TABLE Order_item (
    order_item_id   NUMBER GENERATED ALWAYS AS IDENTITY,
    order_id        NUMBER NOT NULL,
    menu_item_id    NUMBER NOT NULL,
    quantity        NUMBER NOT NULL,
    unit_price      NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_order_item           PRIMARY KEY (order_item_id),
    CONSTRAINT fk_order_item_order     FOREIGN KEY (order_id)     REFERENCES Orders (order_id),
    CONSTRAINT fk_order_item_menu_item FOREIGN KEY (menu_item_id) REFERENCES Menu_item (menu_item_id),
    CONSTRAINT chk_quantity            CHECK (quantity > 0),
    CONSTRAINT chk_unit_price          CHECK (unit_price > 0)
);

--------------------------------------------------------------------------------
-- Menu_item_ingredient (recipe). Pure link table, so it may cascade from the
-- menu item that owns the recipe.
--------------------------------------------------------------------------------
CREATE TABLE Menu_item_ingredient (
    menu_item_id    NUMBER NOT NULL,
    ingredient_id   NUMBER NOT NULL,
    qty_required    NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_menu_item_ingredient PRIMARY KEY (menu_item_id, ingredient_id),
    CONSTRAINT fk_mii_menu_item  FOREIGN KEY (menu_item_id)  REFERENCES Menu_item (menu_item_id) ON DELETE CASCADE,
    CONSTRAINT fk_mii_ingredient FOREIGN KEY (ingredient_id) REFERENCES Ingredient (ingredient_id),
    CONSTRAINT chk_qty_required  CHECK (qty_required > 0)
);

--------------------------------------------------------------------------------
-- Purchase (stock is increased by trg_purchase_stock)
--------------------------------------------------------------------------------
CREATE TABLE Purchase (
    purchase_id     NUMBER GENERATED ALWAYS AS IDENTITY,
    supplier_id     NUMBER NOT NULL,
    ingredient_id   NUMBER NOT NULL,
    quantity        NUMBER(10,2) NOT NULL,
    unit_cost       NUMBER(10,2) NOT NULL,
    purchase_date   DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_purchase            PRIMARY KEY (purchase_id),
    CONSTRAINT fk_purchase_supplier   FOREIGN KEY (supplier_id)   REFERENCES Supplier (supplier_id),
    CONSTRAINT fk_purchase_ingredient FOREIGN KEY (ingredient_id) REFERENCES Ingredient (ingredient_id),
    CONSTRAINT chk_purchase_quantity  CHECK (quantity > 0),
    CONSTRAINT chk_unit_cost          CHECK (unit_cost > 0)
);

--------------------------------------------------------------------------------
-- Payment (no cascade: deleting an order must never delete its payments)
--------------------------------------------------------------------------------
CREATE TABLE Payment (
    payment_id      NUMBER GENERATED ALWAYS AS IDENTITY,
    order_id        NUMBER NOT NULL,
    amount          NUMBER(10,2) NOT NULL,
    method          VARCHAR2(50) NOT NULL,
    status          VARCHAR2(50) DEFAULT 'PENDING' NOT NULL,
    paid_at         TIMESTAMP,
    CONSTRAINT pk_payment          PRIMARY KEY (payment_id),
    CONSTRAINT fk_payment_order    FOREIGN KEY (order_id) REFERENCES Orders (order_id),
    CONSTRAINT chk_amount          CHECK (amount > 0),
    CONSTRAINT chk_payment_method  CHECK (method IN ('CASH', 'CARD', 'ONLINE')),
    CONSTRAINT chk_payment_status  CHECK (status IN ('PENDING', 'COMPLETED', 'FAILED')),
    CONSTRAINT chk_payment_paid_at CHECK (status <> 'COMPLETED' OR paid_at IS NOT NULL)
);

--------------------------------------------------------------------------------
-- Logs
--------------------------------------------------------------------------------
CREATE TABLE Logs (
    log_id          NUMBER GENERATED ALWAYS AS IDENTITY,
    employee_id     NUMBER,
    action_type     VARCHAR2(50),
    table_name      VARCHAR2(100),
    record_id       NUMBER,
    action_details  VARCHAR2(500),
    log_date        DATE DEFAULT SYSDATE,
    CONSTRAINT pk_logs          PRIMARY KEY (log_id),
    CONSTRAINT fk_logs_employee FOREIGN KEY (employee_id) REFERENCES Employee (employee_id)
);

--------------------------------------------------------------------------------
-- Indexes on foreign keys (and common filter columns)
--------------------------------------------------------------------------------
CREATE INDEX ix_menu_item_category    ON Menu_item (category_id);
CREATE INDEX ix_mii_ingredient        ON Menu_item_ingredient (ingredient_id);
CREATE INDEX ix_reservation_customer  ON Reservation (customer_id);
CREATE INDEX ix_reservation_table     ON Reservation (table_id, reservation_start);
CREATE INDEX ix_orders_customer       ON Orders (customer_id);
CREATE INDEX ix_orders_employee       ON Orders (employee_id);
CREATE INDEX ix_orders_table          ON Orders (table_id);
CREATE INDEX ix_orders_reservation    ON Orders (reservation_id);
CREATE INDEX ix_orders_date           ON Orders (order_date);
CREATE INDEX ix_order_item_order      ON Order_item (order_id);
CREATE INDEX ix_order_item_menu_item  ON Order_item (menu_item_id);
CREATE INDEX ix_purchase_supplier     ON Purchase (supplier_id);
CREATE INDEX ix_purchase_ingredient   ON Purchase (ingredient_id);
CREATE INDEX ix_payment_order         ON Payment (order_id);
CREATE INDEX ix_logs_employee         ON Logs (employee_id);
