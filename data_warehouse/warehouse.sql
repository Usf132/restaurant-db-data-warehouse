Table dim_date {
  date_key int [pk]
  full_date date
  day_of_month int
  day_of_week int
  day_name varchar
  week_of_year int
  month_number int
  month_name varchar
  quarter_number int
  year_number int
  is_weekend int
  is_holiday int
  holiday_name varchar
}

Table dim_time {
  time_key int [pk]
  hour_24 int
  hour_12 int
  am_pm varchar
  day_part varchar
}

Table dim_customer {
  customer_key int [pk]
  customer_id int
  name varchar
  phone varchar
  email varchar
  address varchar
  is_active int
  effective_date date
  expiry_date date
  is_current int
}

Table dim_employee {
  employee_key int [pk]
  employee_id int
  name varchar
  phone varchar
  email varchar
  position varchar
  hire_date date
  is_active int
  effective_date date
  expiry_date date
  is_current int
}

Table dim_table {
  table_key int [pk]
  table_id int
  table_number int
  capacity int
  location varchar
}

Table dim_menu_item {
  menu_item_key int [pk]
  menu_item_id int
  item_name varchar
  category_id int
  category_name varchar
  current_price decimal
  is_active int
  effective_date date
  expiry_date date
  is_current int
}

Table dim_ingredient {
  ingredient_key int [pk]
  ingredient_id int
  ingredient_name varchar
  unit varchar
}

Table dim_supplier {
  supplier_key int [pk]
  supplier_id int
  supplier_name varchar
  contact_person varchar
  phone varchar
  email varchar
  address varchar
}

Table dim_payment {
  payment_key int [pk]
  method varchar
  status varchar
}

Table fact_order_item {
  order_item_fact_key int [pk]
  date_key int
  time_key int
  customer_key int
  employee_key int
  table_key int
  menu_item_key int
  order_status varchar
  order_id int
  order_item_id int
  has_reservation int
  quantity int
  unit_price decimal
  line_amount decimal
}

Table fact_payment {
  payment_fact_key int [pk]
  date_key int
  time_key int
  payment_key int
  customer_key int
  employee_key int
  table_key int
  payment_id int
  order_id int
  amount decimal
}

Table fact_reservation {
  reservation_fact_key int [pk]
  date_key int
  time_key int
  customer_key int
  table_key int
  reservation_status varchar
  reservation_id int
  number_of_guests int
  duration_minutes int
  table_capacity int
  reservation_count int
}

Table fact_purchase {
  purchase_fact_key int [pk]
  date_key int
  supplier_key int
  ingredient_key int
  purchase_id int
  quantity decimal
  unit_cost decimal
  total_cost decimal
}

Table fact_inventory_snapshot {
  inventory_fact_key int [pk]
  date_key int
  ingredient_key int
  qty_in_stock decimal
}

Ref: fact_order_item.date_key > dim_date.date_key
Ref: fact_order_item.time_key > dim_time.time_key
Ref: fact_order_item.customer_key > dim_customer.customer_key
Ref: fact_order_item.employee_key > dim_employee.employee_key
Ref: fact_order_item.table_key > dim_table.table_key
Ref: fact_order_item.menu_item_key > dim_menu_item.menu_item_key

Ref: fact_payment.date_key > dim_date.date_key
Ref: fact_payment.time_key > dim_time.time_key
Ref: fact_payment.payment_key > dim_payment.payment_key
Ref: fact_payment.customer_key > dim_customer.customer_key
Ref: fact_payment.employee_key > dim_employee.employee_key
Ref: fact_payment.table_key > dim_table.table_key

Ref: fact_reservation.date_key > dim_date.date_key
Ref: fact_reservation.time_key > dim_time.time_key
Ref: fact_reservation.customer_key > dim_customer.customer_key
Ref: fact_reservation.table_key > dim_table.table_key

Ref: fact_purchase.date_key > dim_date.date_key
Ref: fact_purchase.supplier_key > dim_supplier.supplier_key
Ref: fact_purchase.ingredient_key > dim_ingredient.ingredient_key

Ref: fact_inventory_snapshot.date_key > dim_date.date_key
Ref: fact_inventory_snapshot.ingredient_key > dim_ingredient.ingredient_key