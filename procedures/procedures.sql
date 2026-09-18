--GetCustomerOrders

create or replace procedure getcustomerorders (
   p_customer_id in customer.customer_id%type,
   p_orders      out sys_refcursor
) as
begin
   open p_orders for select o.order_id,
                            o.customer_id,
                            o.table_id,
                            o.emp_d,
                            o.order_date,
                            o.order_time,
                            o.order_statue
                                         from customer_order o
                      where o.customer_id = p_customer_id
                      order by o.order_date desc,
                               o.order_time desc;

end;



VARIABLE rc REFCURSOR;

EXEC GetCustomerOrders(1, :rc);

PRINT rc;


--CreateReservation

create or replace procedure createreservation (
   p_customer_id in reservation.customer_id%type,
   p_table_id    in reservation.table_d%type,
   p_reser_date  in reservation.reser_date%type,
   p_reser_time  in reservation.reser_time%type
) as
   v_count number;
begin

    -- Check if table exists
   select count(*)
     into v_count
     from reservation_table
    where table_id = p_table_id;

   if v_count = 0 then
      raise_application_error(
         -20001,
         'Table does not exist'
      );
   end if;


    -- Check if table is already reserved
   select count(*)
     into v_count
     from reservation
    where table_d = p_table_id
      and reser_date = p_reser_date
      and reser_time = p_reser_time
      and statue = 'CONFIRMED';

   if v_count > 0 then
      raise_application_error(
         -20002,
         'Table is already reserved'
      );
   end if;


    -- Create reservation
   insert into reservation (
      reser_d,
      customer_id,
      table_d,
      reser_date,
      reser_time,
      statue
   ) values
      ( reservation_seq.nextval,
        p_customer_id,
        p_table_id,
        p_reser_date,
        p_reser_time,
        'CONFIRMED' );

end;


--ProcessPayment

create or replace procedure processpayment (
   p_order_id in payment.order_id%type,
   p_amount   in payment.amount_id%type,
   p_method   in payment.method%type
) as
   v_order_total number;
   v_paid_total  number;
begin

    -- Calculate order total
   select nvl(
      sum(quantati * unit_price),
      0
   )
     into v_order_total
     from order_item
    where order_id = p_order_id;


    -- Check order
   if v_order_total = 0 then
      raise_application_error(
         -20003,
         'Order does not exist or has no items'
      );
   end if;


    -- Calculate previous payments
   select nvl(
      sum(amount_id),
      0
   )
     into v_paid_total
     from payment
    where order_id = p_order_id
      and pay_statue = 'PAID';


    -- Prevent overpayment
   if v_paid_total + p_amount > v_order_total then
      raise_application_error(
         -20004,
         'Payment exceeds order total'
      );
   end if;


    -- Insert payment
   insert into payment (
      pay_d,
      order_id,
      amount_id,
      pay_statue,
      pay_date,
      method
   ) values
      ( payment_seq.nextval,
        p_order_id,
        p_amount,
        'PAID',
        sysdate,
        p_method );


    -- If fully paid
   if v_paid_total + p_amount = v_order_total then
      update customer_order
         set
         order_statue = 'PAID'
       where order_id = p_order_id;

   end if;

end;
