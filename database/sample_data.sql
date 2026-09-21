--------------------------------------------------------------------------------
-- Part 3: Data Insertion
-- Customers(10), Employees(5), MenuItems(15), Orders(20),
-- Reservations(10), Suppliers(5), Inventory(10), Payments(20)
--------------------------------------------------------------------------------

-- 1) Customer Data (10)
INSERT INTO Customer (customer_id, name, phone, email, address, is_active) VALUES (1, 'Mariam Hassan', '01011111111', 'mariam@gmail.com', 'Minya', 1);
INSERT INTO Customer (customer_id, name, phone, email, address, is_active) VALUES (2, 'Ahmed Ali', '01022222222', 'ahmed@gmail.com', 'Cairo', 1);
INSERT INTO Customer (customer_id, name, phone, email, address, is_active) VALUES (3, 'Sara Mohamed', '01033333333', 'sara@gmail.com', 'Giza', 1);
INSERT INTO Customer (customer_id, name, phone, email, address, is_active) VALUES (4, 'Omar Hassan', '01044444444', 'omar@gmail.com', 'Minya', 1);
INSERT INTO Customer (customer_id, name, phone, email, address, is_active) VALUES (5, 'Nour Ahmed', '01055555555', 'nour@gmail.com', 'Cairo', 1);
INSERT INTO Customer (customer_id, name, phone, email, address, is_active) VALUES (6, 'Youssef Ali', '01066666666', 'youssef@gmail.com', 'Giza', 1);
INSERT INTO Customer (customer_id, name, phone, email, address, is_active) VALUES (7, 'Salma Adel', '01077777777', 'salma@gmail.com', 'Minya', 1);
INSERT INTO Customer (customer_id, name, phone, email, address, is_active) VALUES (8, 'Karim Samir', '01088888888', 'karim@gmail.com', 'Cairo', 1);
INSERT INTO Customer (customer_id, name, phone, email, address, is_active) VALUES (9, 'Habiba Tarek', '01099999999', 'habiba@gmail.com', 'Assiut', 1);
INSERT INTO Customer (customer_id, name, phone, email, address, is_active) VALUES (10, 'Adham Fathy', '01000000000', 'adham@gmail.com', 'Sohag', 1);
COMMIT;

--------------------------------------------------------------------------------
SELECT * FROM Customer;
--------------------------------------------------------------------------------

-- 2) Restaurant_table Data (8)
INSERT INTO Restaurant_table (table_id, table_number, capacity, location) VALUES (1, 1, 2, 'Indoor');
INSERT INTO Restaurant_table (table_id, table_number, capacity, location) VALUES (2, 2, 4, 'Indoor');
INSERT INTO Restaurant_table (table_id, table_number, capacity, location) VALUES (3, 3, 4, 'Indoor');
INSERT INTO Restaurant_table (table_id, table_number, capacity, location) VALUES (4, 4, 6, 'Indoor');
INSERT INTO Restaurant_table (table_id, table_number, capacity, location) VALUES (5, 5, 2, 'Outdoor');
INSERT INTO Restaurant_table (table_id, table_number, capacity, location) VALUES (6, 6, 4, 'Outdoor');
INSERT INTO Restaurant_table (table_id, table_number, capacity, location) VALUES (7, 7, 6, 'Outdoor');
INSERT INTO Restaurant_table (table_id, table_number, capacity, location) VALUES (8, 8, 8, 'First Floor');
COMMIT;

--------------------------------------------------------------------------------
SELECT * FROM Restaurant_table;
--------------------------------------------------------------------------------

-- 3) Employee Data (5)
INSERT INTO Employee (employee_id, name, phone, email, position, hire_date, salary, is_active) VALUES
       (1, 'Ahmed Hassan', '01111111111', 'ahmed.emp@gmail.com', 'Waiter', DATE '2024-01-10', 6000, 1);
INSERT INTO Employee (employee_id, name, phone, email, position, hire_date, salary, is_active) VALUES
       (2, 'Mohamed Ali', '01122222222', 'mohamed.emp@gmail.com', 'Waiter', DATE '2024-02-15', 6200, 1);
INSERT INTO Employee (employee_id, name, phone, email, position, hire_date, salary, is_active) VALUES
       (3, 'Sara Hassan', '01133333333', 'sara.emp@gmail.com', 'Cashier', DATE '2023-08-20', 7000, 1);
INSERT INTO Employee (employee_id, name, phone, email, position, hire_date, salary, is_active) VALUES
       (4, 'Omar Khaled', '01144444444', 'omar.emp@gmail.com', 'Manager', DATE '2022-05-10', 10000, 1);
INSERT INTO Employee (employee_id, name, phone, email, position, hire_date, salary, is_active) VALUES
       (5, 'Nour Samir', '01155555555', 'nour.emp@gmail.com', 'Chef', DATE '2023-03-12', 8500, 1);
COMMIT;

--------------------------------------------------------------------------------
SELECT * FROM Employee;
--------------------------------------------------------------------------------

-- 4) Menu_category Data (5)
INSERT INTO Menu_category (category_id, category_name) VALUES (1, 'Pizza');
INSERT INTO Menu_category (category_id, category_name) VALUES (2, 'Burger');
INSERT INTO Menu_category (category_id, category_name) VALUES (3, 'Pasta');
INSERT INTO Menu_category (category_id, category_name) VALUES (4, 'Drinks');
INSERT INTO Menu_category (category_id, category_name) VALUES (5, 'Desserts');
COMMIT;

--------------------------------------------------------------------------------
SELECT * FROM Menu_category;
--------------------------------------------------------------------------------

-- 5) Menu_item Data (15)
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (1, 'Margherita Pizza', 1, 150, 1);
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (2, 'Chicken Pizza', 1, 180, 1);
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (3, 'Beef Burger', 2, 200, 1);
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (4, 'Chicken Burger', 2, 170, 1);
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (5, 'Chicken Pasta', 3, 160, 1);
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (6, 'Beef Pasta', 3, 190, 1);
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (7, 'Cola', 4, 40, 1);
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (8, 'Orange Juice', 4, 60, 1);
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (9, 'Cheesecake', 5, 90, 1);
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (10, 'Chocolate Cake', 5, 100, 1);
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (11, 'Veggie Pizza', 1, 160, 1);
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (12, 'Fish Burger', 2, 190, 1);
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (13, 'Seafood Pasta', 3, 210, 1);
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (14, 'Iced Tea', 4, 35, 1);
INSERT INTO Menu_item (menu_item_id, name, category_id, price, is_active) VALUES (15, 'Tiramisu', 5, 110, 1);
COMMIT;

--------------------------------------------------------------------------------
SELECT * FROM Menu_item;
--------------------------------------------------------------------------------

-- 6) Ingredient Data (10)
INSERT INTO Ingredient (ingredient_id, name, unit, qty_in_stock) VALUES (1, 'Flour', 'KG', 50);
INSERT INTO Ingredient (ingredient_id, name, unit, qty_in_stock) VALUES (2, 'Cheese', 'KG', 30);
INSERT INTO Ingredient (ingredient_id, name, unit, qty_in_stock) VALUES (3, 'Chicken', 'KG', 40);
INSERT INTO Ingredient (ingredient_id, name, unit, qty_in_stock) VALUES (4, 'Beef', 'KG', 35);
INSERT INTO Ingredient (ingredient_id, name, unit, qty_in_stock) VALUES (5, 'Tomato', 'KG', 25);
INSERT INTO Ingredient (ingredient_id, name, unit, qty_in_stock) VALUES (6, 'Pasta', 'KG', 30);
INSERT INTO Ingredient (ingredient_id, name, unit, qty_in_stock) VALUES (7, 'Orange', 'KG', 20);
INSERT INTO Ingredient (ingredient_id, name, unit, qty_in_stock) VALUES (8, 'Chocolate', 'KG', 15);
INSERT INTO Ingredient (ingredient_id, name, unit, qty_in_stock) VALUES (9, 'Sugar', 'KG', 25);
INSERT INTO Ingredient (ingredient_id, name, unit, qty_in_stock) VALUES (10, 'Bread', 'PACK', 40);
COMMIT;

--------------------------------------------------------------------------------
SELECT * FROM Ingredient;
--------------------------------------------------------------------------------

-- 7) Supplier Data (5)
INSERT INTO Supplier (supplier_id, name, contact_person, phone, email, address) VALUES
       (1, 'Fresh Food Supplier', 'Hassan Ahmed', '01211111111', 'fresh@gmail.com', 'Cairo');
INSERT INTO Supplier (supplier_id, name, contact_person, phone, email, address) VALUES
       (2, 'Meat House', 'Ali Mohamed', '01222222222', 'meathouse@gmail.com', 'Giza');
INSERT INTO Supplier (supplier_id, name, contact_person, phone, email, address) VALUES
       (3, 'Dairy Market', 'Omar Samir', '01233333333', 'dairy@gmail.com', 'Minya');
INSERT INTO Supplier (supplier_id, name, contact_person, phone, email, address) VALUES
       (4, 'Beverage Supplier', 'Karim Hassan', '01244444444', 'beverage@gmail.com', 'Cairo');
INSERT INTO Supplier (supplier_id, name, contact_person, phone, email, address) VALUES
       (5, 'Bakery Supplies', 'Mona Adel', '01255555555', 'bakery@gmail.com', 'Assiut');
COMMIT;

--------------------------------------------------------------------------------
SELECT * FROM Supplier;
--------------------------------------------------------------------------------

-- 8) Menu_item_ingredient Data
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (1, 1, 0.20);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (1, 2, 0.15);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (1, 5, 0.10);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (2, 1, 0.20);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (2, 2, 0.15);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (2, 3, 0.15);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (2, 5, 0.10);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (3, 4, 0.18);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (3, 2, 0.05);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (3, 10, 1);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (4, 3, 0.18);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (4, 2, 0.05);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (4, 10, 1);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (5, 6, 0.20);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (5, 3, 0.15);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (5, 2, 0.05);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (6, 6, 0.20);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (6, 4, 0.15);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (11, 1, 0.20);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (11, 2, 0.15);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (11, 5, 0.15);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (12, 10, 1);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (12, 2, 0.05);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (13, 6, 0.20);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (13, 2, 0.05);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (13, 5, 0.10);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (14, 9, 0.05);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (15, 9, 0.10);
INSERT INTO Menu_item_ingredient (menu_item_id, ingredient_id, qty_required) VALUES (15, 8, 0.05);
COMMIT;

--------------------------------------------------------------------------------
SELECT * FROM Menu_item_ingredient;
--------------------------------------------------------------------------------

-- 9) Reservation Data (10)
INSERT INTO Reservation (reservation_id, customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES
       (1, 1, 1, TIMESTAMP '2026-09-21 18:00:00', 90, 2, 'CONFIRMED');
INSERT INTO Reservation (reservation_id, customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES
       (2, 2, 2, TIMESTAMP '2026-09-21 19:00:00', 90, 4, 'CONFIRMED');
INSERT INTO Reservation (reservation_id, customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES
       (3, 3, 3, TIMESTAMP '2026-09-21 20:00:00', 120, 3, 'CONFIRMED');
INSERT INTO Reservation (reservation_id, customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES
       (4, 4, 4, TIMESTAMP '2026-09-22 18:30:00', 90, 5, 'CONFIRMED');
INSERT INTO Reservation (reservation_id, customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES
       (5, 5, 5, TIMESTAMP '2026-09-22 20:00:00', 90, 2, 'CONFIRMED');
INSERT INTO Reservation (reservation_id, customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES
       (6, 6, 6, TIMESTAMP '2026-09-23 19:00:00', 90, 4, 'CONFIRMED');
INSERT INTO Reservation (reservation_id, customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES
       (7, 7, 7, TIMESTAMP '2026-09-23 20:00:00', 120, 6, 'CONFIRMED');
INSERT INTO Reservation (reservation_id, customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES
       (8, 8, 8, TIMESTAMP '2026-09-24 18:00:00', 90, 7, 'CONFIRMED');
INSERT INTO Reservation (reservation_id, customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES
       (9, 1, 2, TIMESTAMP '2026-09-24 20:00:00', 90, 4, 'CANCELLED');
INSERT INTO Reservation (reservation_id, customer_id, table_id, reservation_start, duration_minutes, number_of_guests, status) VALUES
       (10, 2, 3, TIMESTAMP '2026-09-25 19:30:00', 90, 3, 'COMPLETED');
COMMIT;

--------------------------------------------------------------------------------
SELECT * FROM Reservation;
--------------------------------------------------------------------------------

-- 10) Orders Data (20)
-- total_amount seeded at 0; trg_order_total fills it in as Order_item rows are inserted
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (1, 1, 1, 1, 1, TO_DATE('2026-09-21 18:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (2, 2, 2, 2, 2, TO_DATE('2026-09-21 19:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (3, 3, 1, 3, 3, TO_DATE('2026-09-21 20:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (4, 4, 2, 4, 4, TO_DATE('2026-09-22 18:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (5, 5, 2, 5, 5, TO_DATE('2026-09-22 20:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (6, 6, 1, 6, 6, TO_DATE('2026-09-23 19:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (7, 7, 2, 7, 7, TO_DATE('2026-09-23 20:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (8, 8, 2, 8, 8, TO_DATE('2026-09-24 18:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (9, 1, 3, 2, NULL, TO_DATE('2026-09-25 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (10, 4, 1, 3, 10, TO_DATE('2026-09-25 19:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (11, 5, 3, 5, NULL, TO_DATE('2026-09-26 12:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (12, 6, 4, 6, NULL, TO_DATE('2026-09-26 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (13, 7, 5, 7, NULL, TO_DATE('2026-09-26 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (14, 8, 1, 8, NULL, TO_DATE('2026-09-26 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (15, 9, 2, 1, NULL, TO_DATE('2026-09-26 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (16, 10, 3, 2, NULL, TO_DATE('2026-09-26 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (17, 1, 4, 3, NULL, TO_DATE('2026-09-27 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (18, 2, 5, 4, NULL, TO_DATE('2026-09-27 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (19, 3, 1, 5, NULL, TO_DATE('2026-09-27 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
INSERT INTO Orders (order_id, customer_id, employee_id, table_id, reservation_id, order_date, status, total_amount) VALUES
       (20, 4, 2, 6, NULL, TO_DATE('2026-09-27 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'OPEN', 0);
COMMIT;

--------------------------------------------------------------------------------
SELECT * FROM Orders;
--------------------------------------------------------------------------------

-- 11) Order_item Data (drives Orders.total_amount via trg_order_total)
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (1, 1, 3, 1, 200);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (2, 1, 7, 1, 40);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (3, 1, 9, 1, 90);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (4, 2, 2, 2, 180);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (5, 2, 7, 2, 40);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (6, 3, 4, 2, 170);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (7, 3, 7, 1, 40);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (8, 3, 9, 1, 90);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (9, 4, 5, 2, 160);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (10, 4, 8, 1, 60);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (11, 4, 10, 1, 100);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (12, 4, 7, 1, 40);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (13, 5, 1, 1, 150);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (14, 5, 7, 1, 40);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (15, 5, 9, 1, 90);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (16, 6, 3, 2, 200);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (17, 6, 8, 1, 60);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (18, 6, 7, 1, 40);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (19, 7, 6, 2, 190);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (20, 7, 8, 1, 60);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (21, 7, 9, 1, 90);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (22, 7, 7, 1, 40);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (23, 8, 2, 2, 180);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (24, 8, 10, 1, 100);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (25, 8, 7, 2, 40);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (26, 9, 3, 1, 200);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (27, 10, 5, 1, 160);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (28, 10, 3, 1, 200);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (29, 10, 7, 1, 40);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (30, 11, 1, 1, 150);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (31, 11, 7, 1, 40);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (32, 12, 4, 1, 170);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (33, 12, 8, 1, 60);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (34, 13, 12, 1, 190);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (35, 13, 14, 1, 35);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (36, 14, 13, 1, 210);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (37, 14, 9, 1, 90);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (38, 15, 11, 1, 160);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (39, 15, 7, 1, 40);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (40, 16, 15, 1, 110);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (41, 16, 6, 1, 190);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (42, 17, 3, 1, 200);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (43, 17, 7, 2, 40);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (44, 18, 2, 1, 180);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (45, 18, 8, 1, 60);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (46, 19, 5, 1, 160);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (47, 19, 10, 1, 100);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (48, 20, 14, 2, 35);
INSERT INTO Order_item (order_item_id, order_id, menu_item_id, quantity, unit_price) VALUES (49, 20, 9, 1, 90);
COMMIT;

--------------------------------------------------------------------------------
SELECT * FROM Order_item;
--------------------------------------------------------------------------------

-- Close every order except the two left unpaid (9 and 20)
UPDATE Orders SET status = 'CLOSED' WHERE order_id NOT IN (9, 20);
COMMIT;

-- 12) Purchase Data
INSERT INTO Purchase (purchase_id, supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (1, 1, 1, 100, 25, DATE '2026-09-01');
INSERT INTO Purchase (purchase_id, supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (2, 3, 2, 50, 180, DATE '2026-09-02');
INSERT INTO Purchase (purchase_id, supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (3, 2, 3, 80, 150, DATE '2026-09-03');
INSERT INTO Purchase (purchase_id, supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (4, 2, 4, 70, 260, DATE '2026-09-04');
INSERT INTO Purchase (purchase_id, supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (5, 1, 5, 60, 30, DATE '2026-09-05');
INSERT INTO Purchase (purchase_id, supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (6, 1, 6, 50, 60, DATE '2026-09-06');
INSERT INTO Purchase (purchase_id, supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (7, 4, 7, 40, 45, DATE '2026-09-07');
INSERT INTO Purchase (purchase_id, supplier_id, ingredient_id, quantity, unit_cost, purchase_date) VALUES (8, 4, 8, 30, 120, DATE '2026-09-08');
COMMIT;

--------------------------------------------------------------------------------
SELECT * FROM Purchase;
--------------------------------------------------------------------------------

-- 13) Payment Data (20)
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (1, 1, 330, 'CASH', 'COMPLETED', TIMESTAMP '2026-09-21 19:00:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (2, 2, 440, 'CARD', 'COMPLETED', TIMESTAMP '2026-09-21 20:00:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (3, 3, 470, 'ONLINE', 'COMPLETED', TIMESTAMP '2026-09-21 21:30:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (4, 4, 520, 'CARD', 'COMPLETED', TIMESTAMP '2026-09-22 20:30:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (5, 5, 280, 'CASH', 'COMPLETED', TIMESTAMP '2026-09-22 21:30:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (6, 6, 500, 'CARD', 'COMPLETED', TIMESTAMP '2026-09-23 20:30:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (7, 7, 570, 'CASH', 'COMPLETED', TIMESTAMP '2026-09-23 21:45:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (8, 8, 540, 'ONLINE', 'COMPLETED', TIMESTAMP '2026-09-24 19:30:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (9, 9, 200, 'CARD', 'PENDING', NULL);
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (10, 10, 400, 'CASH', 'COMPLETED', TIMESTAMP '2026-09-25 20:30:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (11, 11, 190, 'CASH', 'COMPLETED', TIMESTAMP '2026-09-26 12:45:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (12, 12, 230, 'CARD', 'COMPLETED', TIMESTAMP '2026-09-26 13:30:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (13, 13, 225, 'ONLINE', 'COMPLETED', TIMESTAMP '2026-09-26 14:30:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (14, 14, 300, 'CASH', 'COMPLETED', TIMESTAMP '2026-09-26 18:30:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (15, 15, 200, 'CARD', 'COMPLETED', TIMESTAMP '2026-09-26 19:30:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (16, 16, 300, 'CASH', 'COMPLETED', TIMESTAMP '2026-09-26 20:30:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (17, 17, 280, 'ONLINE', 'COMPLETED', TIMESTAMP '2026-09-27 13:00:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (18, 18, 240, 'CARD', 'COMPLETED', TIMESTAMP '2026-09-27 14:00:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (19, 19, 260, 'CASH', 'COMPLETED', TIMESTAMP '2026-09-27 19:00:00');
INSERT INTO Payment (payment_id, order_id, amount, method, status, paid_at) VALUES (20, 20, 160, 'CARD', 'PENDING', NULL);
COMMIT;

--------------------------------------------------------------------------------
SELECT * FROM Payment;
--------------------------------------------------------------------------------

-- 14) Logs Data
INSERT INTO Logs (log_id, employee_id, action_type, table_name, record_id, action_details) VALUES (1, 1, 'INSERT', 'Orders', 1, 'Created new order');
INSERT INTO Logs (log_id, employee_id, action_type, table_name, record_id, action_details) VALUES (2, 2, 'INSERT', 'Orders', 2, 'Created new order');
INSERT INTO Logs (log_id, employee_id, action_type, table_name, record_id, action_details) VALUES (3, 3, 'UPDATE', 'Payment', 1, 'Payment completed');
INSERT INTO Logs (log_id, employee_id, action_type, table_name, record_id, action_details) VALUES (4, 4, 'UPDATE', 'Orders', 4, 'Order reviewed by manager');
INSERT INTO Logs (log_id, employee_id, action_type, table_name, record_id, action_details) VALUES (5, 1, 'UPDATE', 'Orders', 6, 'Order status changed to CLOSED');
INSERT INTO Logs (log_id, employee_id, action_type, table_name, record_id, action_details) VALUES (6, 3, 'INSERT', 'Payment', 6, 'Card payment recorded');
INSERT INTO Logs (log_id, employee_id, action_type, table_name, record_id, action_details) VALUES (7, 2, 'INSERT', 'Orders', 7, 'Created customer order');
INSERT INTO Logs (log_id, employee_id, action_type, table_name, record_id, action_details) VALUES (8, 2, 'UPDATE', 'Orders', 8, 'Order closed');
COMMIT;

--------------------------------------------------------------------------------
SELECT * FROM Logs;
--------------------------------------------------------------------------------
