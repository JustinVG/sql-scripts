set echo on

set linesize 132

set pagesize 66
clear columns
clear breaks
clear computes
btitle off
ttitle off

spool c:\cprg250\module1\assignment2.txt
--Q1
COLUMN "Full Name" FORMAT A22 HEADING 'Full Name'
select First_name ||' '|| Middle_name||' '|| Surname "Full Name", Balance "BALANCE", 
    case when Balance = 0 then 'Zero balance'
         when Balance >= 1 and Balance <= 1000 then  'Low Balance in ' || Account_description
         when Balance >= 1001 and Balance <= 5000 then 'Intermediate Balance in '  || Account_description
         when Balance > 5000 then 'High Balance in '  || Account_description
         end "Balance Level"
from WGB_CUSTOMER natural join WGB_ACCOUNT natural join WGB_ACCOUNT_TYPE
group by First_name, Middle_name, surname, Balance,  Account_description
order by First_name,Balance desc;       
clear columns 




--Q2
set echo off
set verify on
set feedback on
clear columns
clear breaks
COLUMN "AcctType" FORMAT 999 HEADING '  Acct|  Type'
COLUMN "Phone number" FORMAT A18 HEADING 'Phone number '
COLUMN "Largest Balance" FORMAT A11 HEADING '    Largest|    Balance'
select First_name "First",Surname "Last", ('('|| area_code ||') ') || Phone"Phone number", Customer_number "Acct #", Account_type "AcctType", TO_CHAR(Balance, '$99,990.00') "Largest Balance"
from WGB_ACCOUNT natural join WGB_CUSTOMER 
where (Account_type, Balance) in (select Account_type, max(Balance) 
                                    from WGB_ACCOUNT natural join WGB_CUSTOMER  
                                    group by Account_type)
order by Customer_number, Account_type;
--Q3
set echo off
set verify on
set feedback on
clear columns
clear breaks
clear computes
COLUMN "AcctType" FORMAT 999 HEADING '  Acct|  Type'
COLUMN "Largest Balance" FORMAT A11 HEADING '    Lasrgest|    Balance'
COLUMN "Phone Number" FORMAT A13
select First_name "First",Surname "Last", ('('|| area_code ||') ') || Phone"Phone number", wa.Customer_number "Acct #", wa.Account_type "AcctType", TO_CHAR(Balance, '$99,990.00') "Highest Balance"
from WGB_ACCOUNT wa, WGB_CUSTOMER wc  
where wa.Customer_number=wc.Customer_number AND (Account_type, Balance) in (select Account_type, max(Balance) 
                                    from WGB_ACCOUNT natural join WGB_CUSTOMER  
                                    group by Account_type)
order by wa.Customer_number, wa.Account_type;

--Q4
set echo off
set verify on
set feedback on
clear columns
clear breaks
set linesize 132;
set pagesize 66;
column "Full name" format A26 heading 'Full name'
column "Full address" format A40 heading 'Full address'
column "Date entered" format A26 heading 'Date entered'
column "# of accounts" format 99 heading '# of accounts'
select "Full name", "Full address", "Date entered", "# of accounts", rownum "Position"
from (select upper(Surname) || ', ' || First_name as "Full name" , address1 || ', ' || upper(city) || ', ' || province"Full address",
to_char(date_entered, 'MON/YY') as "Date entered", count(transaction_number) "# of accounts"
from WGB_CUSTOMER
join wgb_transaction using(customer_number)
group by upper(Surname) || ', ' || First_name, address1 || ', ' || upper(city) || ', ' || province, date_entered
order by count(transaction_number) desc)
fetch first 2 rows only;


--Q5
column 'Trans. date' format a13
column 'Transaction amount' format a19
column 'Total' justify right
select wc.first_name as "First name", surname as "Last name", transaction_date as "Trans. date",
to_char(transaction_amount, '9,999.00') as "Transaction amount", to_char(sa, '$9,999.00') as "Total"
from wgb_customer wc, 
(select first_name, transaction_date, transaction_amount, sum(transaction_amount) as sa
from wgb_customer natural join wgb_transaction
where address2 is null
group by
rollup (first_name, transaction_date, transaction_amount)) b
where wc.first_name(+) = b.first_name
order by 1,3,4;
clear columns




spool off