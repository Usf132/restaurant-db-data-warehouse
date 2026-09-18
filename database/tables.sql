--------------------------------------------------------------------------------
-- Customer
--------------------------------------------------------------------------------
create table customer (
   customer_id number generated always as identity,
   name        varchar2(100) not null,
   phone       varchar2(20),
   email       varchar2(100),
   address     varchar2(200),
   is_active   number(1) default 1 not null,
   constraint pk_customer primary key ( customer_id ),
   constraint uq_customer_email unique ( email ),
   constraint chk_customer_active check ( is_active in ( 0,
                                                         1 ) )
);

--------------------------------------------------------------------------------
-- Restaurant_table
--------------------------------------------------------------------------------
create table restaurant_table (
   table_id     number generated always as identity,
   table_number number not null,
   capacity     number not null,
   location     varchar2(100),
   constraint pk_restaurant_table primary key ( table_id ),
   constraint uq_table_number unique ( table_number ),
   constraint chk_capacity check ( capacity > 0 )
);

--------------------------------------------------------------------------------
-- Employee
--------------------------------------------------------------------------------
create table employee (
   employee_id number generated always as identity,
   name        varchar2(100) not null,
   phone       varchar2(20),
   email       varchar2(100),
   position    varchar2(50),
   hire_date   date default sysdate,
   salary      number(10,2),
   is_active   number(1) default 1 not null,
   constraint pk_employee primary key ( employee_id ),
   constraint uq_employee_email unique ( email ),
   constraint chk_salary check ( salary > 0 ),
   constraint chk_employee_active check ( is_active in ( 0,
                                                         1 ) )
);

--------------------------------------------------------------------------------
-- Menu_category
--------------------------------------------------------------------------------
create table menu_category (
   category_id   number generated always as identity,
   category_name varchar2(100) not null,
   constraint pk_menu_category primary key ( category_id ),
   constraint uq_category_name unique ( category_name )
);

--------------------------------------------------------------------------------
-- Ingredient
--------------------------------------------------------------------------------
create table ingredient (
   ingredient_id number generated always as identity,
   name          varchar2(100) not null,
   unit          varchar2(20) not null,
   qty_in_stock  number(10,2) default 0 not null,
   constraint pk_ingredient primary key ( ingredient_id ),
   constraint uq_ingredient_name unique ( name ),
   constraint chk_qty_in_stock check ( qty_in_stock >= 0 )
);

--------------------------------------------------------------------------------
-- Supplier
--------------------------------------------------------------------------------
create table supplier (
   supplier_id    number generated always as identity,
   name           varchar2(100) not null,
   contact_person varchar2(100),
   phone          varchar2(20),
   email          varchar2(100),
   address        varchar2(200),
   constraint pk_supplier primary key ( supplier_id ),
   constraint uq_supplier_email unique ( email )
);

--------------------------------------------------------------------------------
-- Menu_item  (category is now a real foreign key to Menu_category)
--------------------------------------------------------------------------------
create table menu_item (
   menu_item_id number generated always as identity,
   name         varchar2(100) not null,
   category_id  number not null,
   price        number(10,2) not null,
   is_active    number(1) default 1 not null,
   constraint pk_menu_item primary key ( menu_item_id ),
   constraint uq_menu_item_name unique ( name ),
   constraint fk_menu_item_category foreign key ( category_id )
      references menu_category ( category_id ),
   constraint chk_price check ( price > 0 ),
   constraint chk_menu_item_active check ( is_active in ( 0,
                                                          1 ) )
);

--------------------------------------------------------------------------------
-- Reservation
--   reservation_start is a single TIMESTAMP (replaces the old DATE + VARCHAR2
--   time pair) so overlap checks are exact. The guest limit is the table's
--   capacity, enforced by trg_reservation_capacity and CreateReservation.
--------------------------------------------------------------------------------
create table reservation (
   reservation_id    number generated always as identity,
   customer_id       number not null,
   table_id          number not null,
   reservation_start timestamp not null,
   duration_minutes  number(4) default 90 not null,
   number_of_guests  number(3) not null,
   status            varchar2(20) default 'CONFIRMED' not null,
   constraint pk_reservation primary key ( reservation_id ),
   constraint fk_res_customer foreign key ( customer_id )
      references customer ( customer_id ),
   constraint fk_res_table foreign key ( table_id )
      references restaurant_table ( table_id ),
   constraint chk_guests check ( number_of_guests > 0 ),
   constraint chk_res_duration check ( duration_minutes between 15 and 480 ),
   constraint chk_reservation_status
      check ( status in ( 'CONFIRMED',
                          'CANCELLED',
                          'COMPLETED' ) )
);

-- Database-level backstop against double booking: at most one CONFIRMED
-- reservation per table per start time. (Overlapping-but-different start times
-- are caught by CreateReservation, which locks the table row first.)
create unique index uq_res_active_slot on
   reservation (
      case
         when
            status
         = 'CONFIRMED' then
               table_id
      end,
      case
         when
            status
         = 'CONFIRMED' then
               reservation_start
      end
   );

--------------------------------------------------------------------------------
-- Orders
--   customer_id is nullable so walk-in guests can be served.
--   total_amount is maintained by trg_order_total.
--------------------------------------------------------------------------------
create table orders (
   order_id       number generated always as identity,
   customer_id    number,
   employee_id    number not null,
   table_id       number not null,
   reservation_id number,
   order_date     date default sysdate not null,
   status         varchar2(20) default 'OPEN' not null,
   total_amount   number(10,2) default 0 not null,
   constraint pk_orders primary key ( order_id ),
   constraint fk_orders_customer foreign key ( customer_id )
      references customer ( customer_id ),
   constraint fk_orders_employee foreign key ( employee_id )
      references employee ( employee_id ),
   constraint fk_orders_table foreign key ( table_id )
      references restaurant_table ( table_id ),
   constraint fk_orders_reservation foreign key ( reservation_id )
      references reservation ( reservation_id ),
   constraint chk_order_status
      check ( status in ( 'OPEN',
                          'CLOSED',
                          'CANCELLED' ) ),
   constraint chk_order_total check ( total_amount >= 0 )
);

--------------------------------------------------------------------------------
-- Order_item
--   unit_price is a snapshot of the menu price at order time (filled
--   automatically by trg_order_item_before when omitted).
--------------------------------------------------------------------------------
create table order_item (
   order_item_id number generated always as identity,
   order_id      number not null,
   menu_item_id  number not null,
   quantity      number not null,
   unit_price    number(10,2) not null,
   constraint pk_order_item primary key ( order_item_id ),
   constraint fk_order_item_order foreign key ( order_id )
      references orders ( order_id ),
   constraint fk_order_item_menu_item foreign key ( menu_item_id )
      references menu_item ( menu_item_id ),
   constraint chk_quantity check ( quantity > 0 ),
   constraint chk_unit_price check ( unit_price > 0 )
);

--------------------------------------------------------------------------------
-- Menu_item_ingredient (recipe). Pure link table, so it may cascade from the
-- menu item that owns the recipe.
--------------------------------------------------------------------------------
create table menu_item_ingredient (
   menu_item_id  number not null,
   ingredient_id number not null,
   qty_required  number(10,2) not null,
   constraint pk_menu_item_ingredient primary key ( menu_item_id,
                                                    ingredient_id ),
   constraint fk_mii_menu_item foreign key ( menu_item_id )
      references menu_item ( menu_item_id )
         on delete cascade,
   constraint fk_mii_ingredient foreign key ( ingredient_id )
      references ingredient ( ingredient_id ),
   constraint chk_qty_required check ( qty_required > 0 )
);

--------------------------------------------------------------------------------
-- Purchase (stock is increased by trg_purchase_stock)
--------------------------------------------------------------------------------
create table purchase (
   purchase_id   number generated always as identity,
   supplier_id   number not null,
   ingredient_id number not null,
   quantity      number(10,2) not null,
   unit_cost     number(10,2) not null,
   purchase_date date default sysdate not null,
   constraint pk_purchase primary key ( purchase_id ),
   constraint fk_purchase_supplier foreign key ( supplier_id )
      references supplier ( supplier_id ),
   constraint fk_purchase_ingredient foreign key ( ingredient_id )
      references ingredient ( ingredient_id ),
   constraint chk_purchase_quantity check ( quantity > 0 ),
   constraint chk_unit_cost check ( unit_cost > 0 )
);

--------------------------------------------------------------------------------
-- Payment (no cascade: deleting an order must never delete its payments)
--------------------------------------------------------------------------------
create table payment (
   payment_id number generated always as identity,
   order_id   number not null,
   amount     number(10,2) not null,
   method     varchar2(50) not null,
   status     varchar2(50) default 'PENDING' not null,
   paid_at    timestamp,
   constraint pk_payment primary key ( payment_id ),
   constraint fk_payment_order foreign key ( order_id )
      references orders ( order_id ),
   constraint chk_amount check ( amount > 0 ),
   constraint chk_payment_method
      check ( method in ( 'CASH',
                          'CARD',
                          'ONLINE' ) ),
   constraint chk_payment_status
      check ( status in ( 'PENDING',
                          'COMPLETED',
                          'FAILED' ) ),
   constraint chk_payment_paid_at
      check ( status <> 'COMPLETED'
          or paid_at is not null )
);

--------------------------------------------------------------------------------
-- Logs
--   db_user is the database login that made the change. employee_id is optional
--   and can be filled by the application when it knows which employee acted.
--------------------------------------------------------------------------------
create table logs (
   log_id         number generated always as identity,
   employee_id    number,
   action_type    varchar2(50),
   table_name     varchar2(100),
   record_id      number,
   action_details varchar2(500),
   log_date       date default sysdate,
   constraint pk_logs primary key ( log_id ),
   constraint fk_logs_employee foreign key ( employee_id )
      references employee ( employee_id )
);
