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
  time_key int [pk]
  hour_24 int
  day_part varchar
}
Table dim_customer {
  customer_key int [pk]
  customer_id int
  name varchar
  phone varchar
  email varchar
  address varchar
  date_of_birth date
  gender varchar
  registration_date date
  customer_status varchar
  loyalty_points int
  total_orders int
  notes varchar
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
  salary decimal
  gender varchar
  date_of_birth date
  address varchar
  emergency_contact varchar
  emergency_phone varchar
  employment_status varchar
  shift varchar
  national_id varchar
  is_active int
  effective_date date
  expiry_date date
  is_current int
}



Table dim_payment {
  payment_key int [pk]
  method varchar
  status varchar
}

Table dim_menu_item {
  menu_item_key int [pk]
  menu_item_id int
  item_name varchar
  category_id int
  category_name varchar
  current_price decimal
  is_active int
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


Table fact_order_item  [headercolor: #E24B4A] {
  order_item_fact_key int [pk]
  date_key int
  customer_key int
  employee_key int
  menu_item_key int
  payment_key int
  order_status varchar
  order_id int
  order_item_id int
  quantity int
  unit_price decimal
  line_amount decimal
  ingredient_cost decimal
  profit decimal
}

Ref: fact_order_item.date_key > dim_date.date_key
Ref: fact_order_item.customer_key > dim_customer.customer_key
Ref: fact_order_item.employee_key > dim_employee.employee_key
Ref: fact_order_item.menu_item_key > dim_menu_item.menu_item_key
Ref: fact_order_item.menu_item_key > dim_ingredient.ingredient_key
Ref: fact_order_item.menu_item_key > dim_supplier.supplier_key
Ref: fact_order_item.menu_item_key > dim_payment.payment_key


Ref: "dim_employee"."employee_key" ?<? "dim_employee"."phone"

Ref: "dim_date"."date_key" ?<>? "dim_date"."day_of_week"

Ref: "dim_ingredient"."ingredient_key" ?<? "dim_ingredient"."ingredient_name"Ref: fact_inventory_snapshot.date_key > dim_date.date_key
Ref: fact_inventory_snapshot.ingredient_key > dim_ingredient.ingredient_key
