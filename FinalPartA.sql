set echo on

set linesize 132

set pagesize 66

spool c:\cprg250\module1\finalpartA.txt

INSERT INTO CP_CATEGORY (category_code, category_description) VALUES (9 , 'Horror');

INSERT INTO CP_TITLE (title_code, film_title, category_code, actors, runtime, star_rating) 
VALUES ('IT', 'IT Chapter One', 9, null, 135, '****');

INSERT INTO CP_TITLE (title_code, film_title, category_code, actors, runtime, star_rating) 
VALUES ('IT2', 'IT Chapter Two', 9, null, 170, '***');

savepoint price_update;
update cp_dvd
set rental_class = 'B'
where rental_class = (select rental_class
   from CP_dvd join CP_TITLE using (title_code)
   where category_code = 8);
rollback to price_update;

savepoint delete_inactive_customers;
delete cp_customer
where customer_no = (select customer_no
    from cp_customer join cp_rental using (customer_no)
    where date_out is null);
rollback to delete_inactive_customers;

spool off

