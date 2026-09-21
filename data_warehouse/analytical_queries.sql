--------------------------------------------------------------------------------
-- Restaurant Data Warehouse - Analytical Queries
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- 1) Revenue by menu category
--------------------------------------------------------------------------------
SELECT m.category_name,
       SUM(f.line_amount) AS revenue
FROM fact_order_item f
JOIN dim_menu_item m ON m.menu_item_key = f.menu_item_key
GROUP BY m.category_name
ORDER BY revenue DESC;

--------------------------------------------------------------------------------
-- 2) Top 5 menu items by revenue
--------------------------------------------------------------------------------
SELECT m.item_name,
       SUM(f.quantity)    AS units_sold,
       SUM(f.line_amount) AS revenue
FROM fact_order_item f
JOIN dim_menu_item m ON m.menu_item_key = f.menu_item_key
GROUP BY m.item_name
ORDER BY revenue DESC
FETCH FIRST 5 ROWS ONLY;

--------------------------------------------------------------------------------
-- 3) Daily revenue trend
--------------------------------------------------------------------------------
SELECT d.full_date,
       SUM(f.line_amount) AS revenue
FROM fact_order_item f
JOIN dim_date d ON d.date_key = f.date_key
GROUP BY d.full_date
ORDER BY d.full_date;

--------------------------------------------------------------------------------
-- 4) Revenue by day of week
--------------------------------------------------------------------------------
SELECT d.day_name,
       SUM(f.line_amount) AS revenue
FROM fact_order_item f
JOIN dim_date d ON d.date_key = f.date_key
GROUP BY d.day_name, d.day_of_week
ORDER BY d.day_of_week;

--------------------------------------------------------------------------------
-- 5) Order volume by time of day (day_part)
--------------------------------------------------------------------------------
SELECT t.day_part,
       COUNT(DISTINCT f.order_id) AS orders,
       SUM(f.line_amount)         AS revenue
FROM fact_order_item f
JOIN dim_time t ON t.time_key = f.time_key
GROUP BY t.day_part
ORDER BY revenue DESC;

--------------------------------------------------------------------------------
-- 6) Reservation status breakdown
--------------------------------------------------------------------------------
SELECT reservation_status,
       COUNT(*) AS reservations,
       ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct_of_total
FROM fact_reservation
GROUP BY reservation_status
ORDER BY reservations DESC;

--------------------------------------------------------------------------------
-- 7) Payment method breakdown
--------------------------------------------------------------------------------
SELECT p.method,
       p.status,
       COUNT(*)        AS payments,
       SUM(f.amount)   AS total_amount
FROM fact_payment f
JOIN dim_payment p ON p.payment_key = f.payment_key
GROUP BY p.method, p.status
ORDER BY total_amount DESC;

--------------------------------------------------------------------------------
-- 8) Top customers by spend
--------------------------------------------------------------------------------
SELECT c.name,
       COUNT(DISTINCT f.order_id) AS orders,
       SUM(f.line_amount)         AS total_spend
FROM fact_order_item f
JOIN dim_customer c ON c.customer_key = f.customer_key
GROUP BY c.name
ORDER BY total_spend DESC
FETCH FIRST 10 ROWS ONLY;

--------------------------------------------------------------------------------
-- 9) Purchase spend by supplier
--------------------------------------------------------------------------------
SELECT s.supplier_name,
       SUM(f.total_cost) AS total_spend
FROM fact_purchase f
JOIN dim_supplier s ON s.supplier_key = f.supplier_key
GROUP BY s.supplier_name
ORDER BY total_spend DESC;

--------------------------------------------------------------------------------
-- 10) Ingredients below a reorder threshold (latest snapshot per ingredient)
--------------------------------------------------------------------------------
SELECT i.ingredient_name,
       i.unit,
       s.qty_in_stock
FROM fact_inventory_snapshot s
JOIN dim_ingredient i ON i.ingredient_key = s.ingredient_key
WHERE s.date_key = (
    SELECT MAX(date_key) FROM fact_inventory_snapshot s2
    WHERE s2.ingredient_key = s.ingredient_key
)
AND s.qty_in_stock < 10
ORDER BY s.qty_in_stock;
