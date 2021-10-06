set echo on

set linesize 132

set pagesize 66

spool c:\cprg250\module1\assignment1.txt

select Customer_Number "Cust #", Account_type "Account Type", Date_created "Date", REPLACE(Address1, 'Apt', 'Apartment') "Address"
from wgb_account wa join wgb_customer wc using(customer_number)
where date_created LIKE '%JUL%'
order by 1;
 
 select first_name "First", surname "Last", phone "Phone", wc.customer_number "Cust #",account_type "Type", balance "$"
 from wgb_account wa, wgb_customer wc
 where wa.customer_number = wc.customer_number
 AND account_type=1
 order by 2,1,4,5;
  
  select first_name "First", surname "Last", phone "Phone", wc.customer_number "Cust #", account_type "Type", balance "$"
  from wgb_customer wc join wgb_account wa on (wc.customer_number=wa.customer_number)
  where account_type=2
  order by 2,1,4,5;
  
  column "Amount" format A12
 select first_name "Name", account_description "Description", balance "BALANCE", transaction_date "Date", lpad(transaction_amount,9,'*') "Amount"
 from wgb_account_type wat, wgb_account wa, wgb_customer wc, wgb_transaction wt
 where wat.account_type=wa.account_type AND wa.customer_number=wc.customer_number AND wa.customer_number=wt.customer_number AND wa.account_type=wt.account_type
 and wat.account_description like '%Interest%';
 clear columns
  
  select first_name "First", surname "Last", customer_number "Cust #", TO_CHAR(date_created,'DD/MON/YY') "Date", account_type "Type"
  from wgb_customer wc join wgb_account wa using (customer_number)
  order by 2,1,3,5;
  
  select first_name "First", surname "Last", customer_number "Cust #",
   CASE account_type
      WHEN 1 THEN 'Chq'
      WHEN 2 THEN 'Daily Sav'
      WHEN 3 THEN 'Mthly Sav'
      WHEN 4 THEN 'RRSP'
      WHEN 5 THEN 'GIC'
      ELSE 'null' END "Type",
      TO_CHAR(balance,'$99,990.00') "Opening Balance"
   from wgb_account join wgb_customer using (customer_number)
   order by 1;
   
   spool off