-- Categories ------------------------------------------------------------------
INSERT INTO Menu_category (category_name) VALUES ('Starters');       -- 1
INSERT INTO Menu_category (category_name) VALUES ('Main Courses');   -- 2
INSERT INTO Menu_category (category_name) VALUES ('Desserts');       -- 3
INSERT INTO Menu_category (category_name) VALUES ('Beverages');      -- 4

-- Customers -------------------------------------------------------------------
INSERT INTO Customer (name, phone, email, address) VALUES ('Nour Hassan',    '01011111111', 'nour.hassan@example.com',    '12 Nile St');           -- 1
INSERT INTO Customer (name, phone, email, address) VALUES ('Karim Adel',     '01022222222', 'karim.adel@example.com',     '5 Garden Ave');         -- 2
INSERT INTO Customer (name, phone, email, address) VALUES ('Layla Mahmoud',  '01033333333', 'layla.mahmoud@example.com',  '48 Palm Rd');           -- 3
INSERT INTO Customer (name, phone, email, address) VALUES ('Youssef Samir',  '01044444444', 'youssef.samir@example.com',  '9 Market Sq');          -- 4
INSERT INTO Customer (name, phone, email, address) VALUES ('Hana Ibrahim',   '01055555555', 'hana.ibrahim@example.com',   '31 Corniche');          -- 5
INSERT INTO Customer (name, phone, email, address) VALUES ('Tarek Fouad',    '01066666666', 'tarek.fouad@example.com',    '77 Station Rd');        -- 6
INSERT INTO Customer (name, phone, email, address) VALUES ('Dina Samy',      '01077777777', 'dina.samy@example.com',      '3 University Ln');      -- 7
INSERT INTO Customer (name, phone, email, address) VALUES ('Mostafa Reda',   '01088888888', 'mostafa.reda@example.com',   '20 Orchard Way');       -- 8

-- Restaurant tables -----------------------------------------------------------
INSERT INTO Restaurant_table (table_number, capacity, location) VALUES (1, 2, 'Indoor');        -- 1
INSERT INTO Restaurant_table (table_number, capacity, location) VALUES (2, 2, 'Indoor');        -- 2
INSERT INTO Restaurant_table (table_number, capacity, location) VALUES (3, 4, 'Indoor');        -- 3
INSERT INTO Restaurant_table (table_number, capacity, location) VALUES (4, 4, 'Terrace');       -- 4
INSERT INTO Restaurant_table (table_number, capacity, location) VALUES (5, 6, 'Terrace');       -- 5
INSERT INTO Restaurant_table (table_number, capacity, location) VALUES (6, 8, 'Private Room');  -- 6

-- Employees -------------------------------------------------------------------
INSERT INTO Employee (name, phone, email, position, hire_date, salary) VALUES ('Ahmed Hassan',  '01100000001', 'ahmed.hassan@resto.example', 'Waiter',  DATE '2024-02-01', 6500);   -- 1
INSERT INTO Employee (name, phone, email, position, hire_date, salary) VALUES ('Sara Mostafa',  '01100000002', 'sara.mostafa@resto.example', 'Waiter',  DATE '2024-05-15', 6500);   -- 2
INSERT INTO Employee (name, phone, email, position, hire_date, salary) VALUES ('Omar Khaled',   '01100000003', 'omar.khaled@resto.example',  'Manager', DATE '2023-01-10', 15000);  -- 3
INSERT INTO Employee (name, phone, email, position, hire_date, salary) VALUES ('Mona Adel',     '01100000004', 'mona.adel@resto.example',    'Cashier', DATE '2025-03-01', 7000);   -- 4

-- Suppliers -------------------------------------------------------------------
INSERT INTO Supplier (name, contact_person, phone, email, address) VALUES ('Fresh Farms',              'Hossam Nabil', '01200000001', 'sales@freshfarms.example',  'Agri Zone 4');       -- 1
INSERT INTO Supplier (name, contact_person, phone, email, address) VALUES ('Delta Meats & Poultry',    'Wael Saad',    '01200000002', 'orders@deltameat.example',  'Industrial Area 2'); -- 2
INSERT INTO Supplier (name, contact_person, phone, email, address) VALUES ('Nile Dairy & Dry Goods',   'Rania Fathy',  '01200000003', 'info@niledairy.example',    'Logistics Park 7');  -- 3

-- Ingredients (stock starts at 0 and is filled by purchases) ------------------
INSERT INTO Ingredient (name, unit) VALUES ('Lentils',        'kg');   -- 1
INSERT INTO Ingredient (name, unit) VALUES ('Chicken breast', 'kg');   -- 2
INSERT INTO Ingredient (name, unit) VALUES ('Ground beef',    'kg');   -- 3
INSERT INTO Ingredient (name, unit) VALUES ('Tomatoes',       'kg');   -- 4
INSERT INTO Ingredient (name, unit) VALUES ('Lettuce',        'kg');   -- 5
INSERT INTO Ingredient (name, unit) VALUES ('Flour',          'kg');   -- 6
INSERT INTO Ingredient (name, unit) VALUES ('Mozzarella',     'kg');   -- 7
INSERT INTO Ingredient (name, unit) VALUES ('Dark chocolate', 'kg');   -- 8
INSERT INTO Ingredient (name, unit) VALUES ('Milk',           'l');    -- 9
INSERT INTO Ingredient (name, unit) VALUES ('Oranges',        'kg');   -- 10
INSERT INTO Ingredient (name, unit) VALUES ('Coffee beans',   'kg');   -- 11
INSERT INTO Ingredient (name, unit) VALUES ('Lemons',         'kg');   -- 12

-- Menu items ------------------------------------------------------------------
INSERT INTO Menu_item (name, category_id, price) VALUES ('Lentil Soup',           1,  45);   -- 1
INSERT INTO Menu_item (name, category_id, price) VALUES ('Fattoush Salad',        1,  55);   -- 2
INSERT INTO Menu_item (name, category_id, price) VALUES ('Grilled Chicken',       2, 160);   -- 3
INSERT INTO Menu_item (name, category_id, price) VALUES ('Beef Kofta Plate',      2, 185);   -- 4
INSERT INTO Menu_item (name, category_id, price) VALUES ('Margherita Pizza',      2, 140);   -- 5
INSERT INTO Menu_item (name, category_id, price) VALUES ('Molten Chocolate Cake', 3,  75);   -- 6
INSERT INTO Menu_item (name, category_id, price) VALUES ('Umm Ali',               3,  65);   -- 7
INSERT INTO Menu_item (name, category_id, price) VALUES ('Fresh Orange Juice',    4,  40);   -- 8
INSERT INTO Menu_item (name, category_id, price) VALUES ('Turkish Coffee',        4,  30);   -- 9
INSERT INTO Menu_item (name, category_id, price) VALUES ('Mint Lemonade',         4,  35);   -- 10

-- Recipes (menu_item_id, ingredient_id, qty per portion) ----------------------
INSERT INTO Menu_item_ingredient VALUES (1,  1, 0.15);   -- Lentil Soup: lentils
INSERT INTO Menu_item_ingredient VALUES (1,  4, 0.05);   --              tomatoes
INSERT INTO Menu_item_ingredient VALUES (2,  5, 0.10);   -- Fattoush: lettuce
INSERT INTO Menu_item_ingredient VALUES (2,  4, 0.08);   --            tomatoes
INSERT INTO Menu_item_ingredient VALUES (3,  2, 0.35);   -- Grilled Chicken: chicken
INSERT INTO Menu_item_ingredient VALUES (3,  4, 0.05);   --                  tomatoes
INSERT INTO Menu_item_ingredient VALUES (4,  3, 0.30);   -- Kofta: beef
INSERT INTO Menu_item_ingredient VALUES (4,  4, 0.05);   --         tomatoes
INSERT INTO Menu_item_ingredient VALUES (4,  5, 0.05);   --         lettuce
INSERT INTO Menu_item_ingredient VALUES (5,  6, 0.25);   -- Pizza: flour
INSERT INTO Menu_item_ingredient VALUES (5,  7, 0.20);   --        mozzarella
INSERT INTO Menu_item_ingredient VALUES (5,  4, 0.10);   --        tomatoes
INSERT INTO Menu_item_ingredient VALUES (6,  8, 0.10);   -- Choc cake: chocolate
INSERT INTO Menu_item_ingredient VALUES (6,  6, 0.05);   --            flour
INSERT INTO Menu_item_ingredient VALUES (6,  9, 0.05);   --            milk
INSERT INTO Menu_item_ingredient VALUES (7,  9, 0.25);   -- Umm Ali: milk
INSERT INTO Menu_item_ingredient VALUES (7,  6, 0.10);   --          flour
INSERT INTO Menu_item_ingredient VALUES (8, 10, 0.50);   -- Orange juice: oranges
INSERT INTO Menu_item_ingredient VALUES (9, 11, 0.02);   -- Coffee: beans
INSERT INTO Menu_item_ingredient VALUES (10, 12, 0.20);  -- Lemonade: lemons

-- Purchases: initial stock (June) and a restock at different prices (August) --
-- supplier_id, ingredient_id, quantity, unit_cost, purchase_date
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (3,  1, 20,  60, DATE '2026-06-01');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (2,  2, 40, 180, DATE '2026-06-01');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (2,  3, 40, 320, DATE '2026-06-01');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (1,  4, 60,  25, DATE '2026-06-01');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (1,  5, 25,  30, DATE '2026-06-01');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (3,  6, 50,  20, DATE '2026-06-01');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (3,  7, 25, 250, DATE '2026-06-01');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (3,  8,  8, 400, DATE '2026-06-01');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (3,  9, 60,  35, DATE '2026-06-01');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (1, 10, 60,  25, DATE '2026-06-01');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (3, 11,  5, 600, DATE '2026-06-01');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (1, 12, 25,  30, DATE '2026-06-01');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (2,  2, 20, 190, DATE '2026-08-03');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (2,  3, 20, 335, DATE '2026-08-03');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (1,  4, 30,  28, DATE '2026-08-03');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (3,  7, 10, 260, DATE '2026-08-03');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (3,  9, 30,  38, DATE '2026-08-03');
INSERT INTO Purchase (supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (3, 11,  3, 620, DATE '2026-08-03');

-- Reservations (guests never exceed the table capacity) ------------------------
-- customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status
INSERT INTO Reservation (customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES (1, 3, TIMESTAMP '2026-06-05 20:00:00',  90, 4, 'COMPLETED');   -- 1
INSERT INTO Reservation (customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES (3, 5, TIMESTAMP '2026-07-03 19:00:00',  90, 6, 'COMPLETED');   -- 2
INSERT INTO Reservation (customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES (1, 6, TIMESTAMP '2026-07-25 20:30:00', 120, 8, 'COMPLETED');   -- 3
INSERT INTO Reservation (customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES (5, 4, TIMESTAMP '2026-09-25 20:00:00',  90, 4, 'CONFIRMED');   -- 4
INSERT INTO Reservation (customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES (8, 3, TIMESTAMP '2026-09-26 19:30:00',  90, 3, 'CONFIRMED');   -- 5
INSERT INTO Reservation (customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES (2, 1, TIMESTAMP '2026-09-27 21:00:00',  90, 2, 'CANCELLED');   -- 6

-- Orders (all start OPEN; customer_id NULL = walk-in) -------------------------
-- customer_id, employee_id, table_id, reservation_id, order_date
INSERT INTO Orders (customer_id, employee_id, table_id, reservation_id, order_date) VALUES (1,    1, 3, 1,    TO_DATE('2026-06-05 20:15', 'YYYY-MM-DD HH24:MI'));   -- 1
INSERT INTO Orders (customer_id, employee_id, table_id, reservation_id, order_date) VALUES (2,    2, 1, NULL, TO_DATE('2026-06-12 13:40', 'YYYY-MM-DD HH24:MI'));   -- 2
INSERT INTO Orders (customer_id, employee_id, table_id, reservation_id, order_date) VALUES (NULL, 1, 2, NULL, TO_DATE('2026-06-20 21:05', 'YYYY-MM-DD HH24:MI'));   -- 3 walk-in
INSERT INTO Orders (customer_id, employee_id, table_id, reservation_id, order_date) VALUES (3,    2, 5, 2,    TO_DATE('2026-07-03 19:30', 'YYYY-MM-DD HH24:MI'));   -- 4
INSERT INTO Orders (customer_id, employee_id, table_id, reservation_id, order_date) VALUES (4,    1, 4, NULL, TO_DATE('2026-07-17 14:10', 'YYYY-MM-DD HH24:MI'));   -- 5
INSERT INTO Orders (customer_id, employee_id, table_id, reservation_id, order_date) VALUES (1,    2, 6, 3,    TO_DATE('2026-07-25 20:45', 'YYYY-MM-DD HH24:MI'));   -- 6
INSERT INTO Orders (customer_id, employee_id, table_id, reservation_id, order_date) VALUES (5,    1, 3, NULL, TO_DATE('2026-08-08 18:20', 'YYYY-MM-DD HH24:MI'));   -- 7
INSERT INTO Orders (customer_id, employee_id, table_id, reservation_id, order_date) VALUES (NULL, 2, 1, NULL, TO_DATE('2026-08-15 12:30', 'YYYY-MM-DD HH24:MI'));   -- 8 walk-in
INSERT INTO Orders (customer_id, employee_id, table_id, reservation_id, order_date) VALUES (2,    1, 5, NULL, TO_DATE('2026-09-05 21:00', 'YYYY-MM-DD HH24:MI'));   -- 9
INSERT INTO Orders (customer_id, employee_id, table_id, reservation_id, order_date) VALUES (6,    2, 2, NULL, TO_DATE('2026-09-10 19:00', 'YYYY-MM-DD HH24:MI'));   -- 10 (cancelled below)
INSERT INTO Orders (customer_id, employee_id, table_id, reservation_id, order_date) VALUES (7,    1, 4, NULL, SYSDATE - 1/24);                                        -- 11 (stays OPEN)

-- Order lines: unit_price is filled from the menu by the trigger --------------
-- order_id, menu_item_id, quantity
INSERT INTO Order_item (order_id, menu_item_id, quantity)
SELECT 1, 1, 2 FROM dual UNION ALL SELECT 1, 3, 2 FROM dual UNION ALL SELECT 1, 8, 2 FROM dual UNION ALL SELECT 1, 6, 1 FROM dual UNION ALL
SELECT 2, 2, 1 FROM dual UNION ALL SELECT 2, 5, 1 FROM dual UNION ALL SELECT 2, 10, 1 FROM dual UNION ALL
SELECT 3, 4, 1 FROM dual UNION ALL SELECT 3, 9, 1 FROM dual UNION ALL
SELECT 4, 1, 3 FROM dual UNION ALL SELECT 4, 4, 3 FROM dual UNION ALL SELECT 4, 5, 1 FROM dual UNION ALL SELECT 4, 7, 3 FROM dual UNION ALL SELECT 4, 8, 3 FROM dual UNION ALL
SELECT 5, 5, 2 FROM dual UNION ALL SELECT 5, 2, 2 FROM dual UNION ALL SELECT 5, 10, 2 FROM dual UNION ALL
SELECT 6, 3, 4 FROM dual UNION ALL SELECT 6, 4, 3 FROM dual UNION ALL SELECT 6, 1, 4 FROM dual UNION ALL SELECT 6, 6, 4 FROM dual UNION ALL SELECT 6, 9, 4 FROM dual UNION ALL SELECT 6, 8, 2 FROM dual UNION ALL
SELECT 7, 3, 1 FROM dual UNION ALL SELECT 7, 7, 1 FROM dual UNION ALL SELECT 7, 9, 2 FROM dual UNION ALL
SELECT 8, 5, 1 FROM dual UNION ALL SELECT 8, 8, 1 FROM dual UNION ALL
SELECT 9, 4, 2 FROM dual UNION ALL SELECT 9, 3, 1 FROM dual UNION ALL SELECT 9, 2, 2 FROM dual UNION ALL SELECT 9, 6, 2 FROM dual UNION ALL SELECT 9, 9, 3 FROM dual UNION ALL
SELECT 10, 3, 2 FROM dual UNION ALL SELECT 10, 8, 2 FROM dual UNION ALL
SELECT 11, 5, 2 FROM dual UNION ALL SELECT 11, 10, 2 FROM dual UNION ALL SELECT 11, 9, 1 FROM dual;

-- Payments for the finished orders (1-9); order 6 is split across two payments --
INSERT INTO Payment (order_id, amount, method, status, paid_at)
SELECT order_id,
       total_amount,
       CASE MOD(order_id, 3) WHEN 0 THEN 'CASH' WHEN 1 THEN 'CARD' ELSE 'ONLINE' END,
       'COMPLETED',
       CAST(order_date + 1.5/24 AS TIMESTAMP)
  FROM Orders
 WHERE order_id BETWEEN 1 AND 9
   AND order_id <> 6;

INSERT INTO Payment (order_id, amount, method, status, paid_at)
SELECT order_id, ROUND(total_amount / 2, 2), 'CARD', 'COMPLETED', CAST(order_date + 1/24 AS TIMESTAMP)
  FROM Orders WHERE order_id = 6;

INSERT INTO Payment (order_id, amount, method, status, paid_at)
SELECT order_id, total_amount - ROUND(total_amount / 2, 2), 'CASH', 'COMPLETED', CAST(order_date + 1.5/24 AS TIMESTAMP)
  FROM Orders WHERE order_id = 6;

-- A declined card attempt on order 5 (FAILED payments do not count as paid)
INSERT INTO Payment (order_id, amount, method, status)
SELECT order_id, total_amount, 'CARD', 'FAILED' FROM Orders WHERE order_id = 5;

-- Close the paid orders, cancel order 10 (its ingredients go back to stock) ----
UPDATE Orders SET status = 'CLOSED'    WHERE order_id BETWEEN 1 AND 9;
UPDATE Orders SET status = 'CANCELLED' WHERE order_id = 10;

-- Price change AFTER the orders: old orders keep 140, the change is logged ----
UPDATE Menu_item SET price = 150 WHERE name = 'Margherita Pizza';

COMMIT;
