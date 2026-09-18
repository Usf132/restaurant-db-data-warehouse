-- Customer

create table customer (
   customer_id number, --GENERATED ALWAYS AS IDENTITY
   name        varchar2(100) not null,
   phone       varchar2(20),
   email       varchar2(100) unique,
   address     varchar2(200),
   constraint pk_customer primary key ( customer_id )
);
-- Restaurant Table

create table restaurant_table (
   table_id     number,-- GENERATED ALWAYS AS IDENTITY
   table_number number not null,
   capacity     number not null,
   location     varchar2(100),
   constraint pk_restaurant_table primary key ( table_id ),
   constraint uq_table_number unique ( table_number ),
   constraint chk_capacity check ( capacity > 0 )
);
-- Employee

create table employee (
   employee_id number,-- GENERATED ALWAYS AS IDENTITY
   name        varchar2(100) not null,
   phone       varchar2(20),
   email       varchar2(100) unique,
   position    varchar2(50),
   hire_date   date default sysdate,
   salary      number(10,2),
   constraint pk_employee primary key ( employee_id ),
   constraint chk_salary check ( salary > 0 )
);
-- Menu Category

create table menu_category (
   category_id   number,-- GENERATED ALWAYS AS IDENTITY
   category_name varchar2(100) not null,
   constraint pk_menu_category primary key ( category_id ),
   constraint uq_category_name unique ( category_name )
);
-- Ingredient

create table ingredient (
   ingredient_id number,--GENERATED ALWAYS AS IDENTITY
   name          varchar2(100) not null,
   unit          varchar2(20) not null,
   qty_in_stock  number(10,2) default 0,
   constraint pk_ingredient primary key ( ingredient_id ),
   constraint chk_qty_in_stock check ( qty_in_stock >= 0 )
);
-- Supplier

create table supplier (
   supplier_id    number,--GENERATED ALWAYS AS IDENTITY
   name           varchar2(100) not null,
   contact_person varchar2(100),
   phone          varchar2(20),
   email          varchar2(100) unique,
   address        varchar2(200),
   constraint pk_supplier primary key ( supplier_id )
);
-- Menu Item

create table menu_item (
   menu_item_id number,-- GENERATED ALWAYS AS IDENTITY
   name         varchar2(100) not null,
   category     varchar2(50),
   price        number(10,2) not null,
   constraint pk_menu_item primary key ( menu_item_id ),
   constraint chk_price check ( price > 0 )
);
-- Reservation

create table reservation (
   reservation_id   number,--GENERATED ALWAYS AS IDENTITY
   customer_id      number not null,
   table_id         number not null,
   reservation_date date not null,
   reservation_time varchar2(10) not null,
   number_of_guests number not null,
   status           varchar2(20) default 'CONFIRMED',
   constraint pk_reservation primary key ( reservation_id ),
   constraint fk_res_customer foreign key ( customer_id )
      references customer ( customer_id )
         on delete cascade,
   constraint fk_res_table foreign key ( table_id )
      references restaurant_table ( table_id ),
   constraint chk_guests
      check ( number_of_guests > 0
         and number_of_guests <= 20 ),
   constraint chk_reservation_status
      check ( status in ( 'CONFIRMED',
                          'CANCELLED',
                          'COMPLETED' ) )
);
-- Orders

create table orders (
   order_id    number,-- GENERATED ALWAYS AS IDENTITY
   customer_id number not null,
   employee_id number not null,
   table_id    number not null,
   order_date  date default sysdate,
   status      varchar2(20) default 'OPEN',
   totalamount number(10,2) default 0,
   constraint pk_orders primary key ( order_id ),
   constraint fk_orders_customer foreign key ( customer_id )
      references customer ( customer_id ),
   constraint fk_orders_employee foreign key ( employee_id )
      references employee ( employee_id ),
   constraint fk_orders_table foreign key ( table_id )
      references restaurant_table ( table_id ),
   constraint chk_order_status
      check ( status in ( 'OPEN',
                          'CLOSED',
                          'CANCELLED' ) )
);
-- Order_item

create table order_item (
   order_item_id number,-- GENERATED ALWAYS AS IDENTITY
   order_id      number not null,
   menu_item_id  number not null,
   quantity      number not null,
   unit_price    number(10,2) not null,
   constraint pk_order_item primary key ( order_item_id ),
   constraint fk_order_item_order foreign key ( order_id )
      references orders ( order_id )
         on delete cascade,
   constraint fk_order_item_menu_item foreign key ( menu_item_id )
      references menu_item ( menu_item_id ),
   constraint chk_quantity check ( quantity > 0 ),
   constraint chk_unit_price check ( unit_price > 0 )
);
--Menu_item_ingredient

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
-- Purchase

create table purchase (
   purchase_id   number, --GENERATED ALWAYS AS IDENTITY
   supplier_id   number not null,
   ingredient_id number not null,
   quantity      number(10,2) not null,
   unit_cost     number(10,2) not null,
   purchase_date date default sysdate,
   constraint pk_purchase primary key ( purchase_id ),
   constraint fk_purchase_supplier foreign key ( supplier_id )
      references supplier ( supplier_id ),
   constraint fk_purchase_ingredient foreign key ( ingredient_id )
      references ingredient ( ingredient_id ),
   constraint chk_purchase_quantity check ( quantity > 0 ),
   constraint chk_unit_cost check ( unit_cost > 0 )
);
-- Payment

create table payment (
   payment_id number,-- GENERATED ALWAYS AS IDENTITY
   order_id   number not null,
   amount     number(10,2) not null,
   method     varchar2(50) not null,
   status     varchar2(50) default 'Pending',
   paid_at    timestamp,
   constraint pk_payment primary key ( payment_id ),
   constraint fk_payment_order foreign key ( order_id )
      references orders ( order_id )
         on delete cascade,
   constraint chk_amount check ( amount > 0 ),
   constraint chk_payment_method
      check ( method in ( 'Cash',
                          'Card',
                          'Online' ) ),
   constraint chk_payment_status
      check ( status in ( 'Pending',
                          'Completed',
                          'Failed' ) )
);
-- Logs

create table logs (
   log_id         number,-- GENERATED ALWAYS AS IDENTITY
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
