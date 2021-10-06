set echo on

set linesize 132

set pagesize 66

spool c:\cprg250\module1\lab4output.txt

column "Pub Date" format a20
select initcap(lname) "Surname", initcap(title) "Book Title", to_char(pubdate, 'fmMonth dd, yyyy') "Pub Date", retail-nvl(discount,0) "Final Price"
from books join bookauthor using (isbn) join author using (authorid)
order by 2;
clear columns

col "colname" format a20
col "Date Published" format a15
col "Review Date" format a15
select title "Book Title", pubdate "Date Published", ADD_MONTHS(pubdate,6) "Review Date" 
from books order by "Book Title";
clear columns

col "% Profit" format a10
select initcap(title) "Book Title", TO_CHAR((retail-nvl(discount,0)),'99.99') "Price", TO_CHAR(cost,'99.99') "Cost", TO_CHAR(((((retail-nvl(discount,0))-cost)/cost)*100),'999.99') "% Profit" 
from books order by "% Profit" desc;
clear columns

col "Discount" format a8
select initcap(title) "Book Title", to_char((retail-cost)/cost*100, '999.99') "Margin",to_char(discount, '999.99') "Discount", case when discount is not null then 'Discounted, will NOT be restocked'
when((retail-cost)/cost*100) >= 60 then 'Very high profit'
when((retail-cost)/cost*100) >= 30 then 'High profit'
when((retail-cost)/cost*100) >= 0 then 'Loss Leader' END "Pricing Structure"
from books
order by 1;


spool off
set echo on

set linesize 132

set pagesize 66

spool c:\cprg250\module1\lab3output.txt

select firstname, lastname, oi.order# , item# , title, gift
from customers c , orders o , orderitems oi, books b , promotion p
where c.customer# = o.customer# and o.order# = oi.order# and oi.isbn = b.isbn and b.retail between p.minretail and p.maxretail
order by lastname;

select firstname, lastname, oi.order# , item# , title, gift
from customers c join orders o on c.customer# = o.customer# join orderitems oi on o.order# = oi.order# join books b on oi.isbn = b.isbn join promotion p on b.retail between p.minretail and p.maxretail
order by lastname;

select distinct firstname || ' ' || lastname as "Customer Name" , fname || ' ' || lname as "Author Name"
from customers c, orders o, orderitems oi, books b , bookauthor ba,  author a
where c.customer# = o.customer# and o.order# = oi.order# and oi.isbn = b.isbn and b.isbn = ba.isbn and ba.authorid = a.authorid
order by "Customer Name";

select distinct firstname || ' ' || lastname as "Customer Name", fname || ' ' || lname as "Author Name"
from customers c natural join orders o natural join orderitems oi natural join books b natural join bookauthor ba natural join author a
order by "Customer Name";

 select distinct firstname || ' ' || lastname as "Customer Name", fname || ' ' || lname as "Author Name"
 from customers join orders using (customer#) join orderitems using (order#) join books using(isbn) join bookauthor using(isbn) join author using(authorid)
 order by "Customer Name";
 
 select distinct firstname || ' ' || lastname as "Customer Name", fname || ' ' || lname as "Author Name"
 from customers c join orders o on (c.customer#=o.customer#) join orderitems oi on(o.order#=oi.order#) join books b on(oi.isbn=b.isbn) join bookauthor ba on(b.isbn=ba.isbn) join author a on(ba.authorid=a.authorid)
 order by "Customer Name";
 
 select fname, lname, title
 from author full outer join bookauthor using (authorid) full outer join books using (isbn)
 order by lname;
 
 spool off
 
 
 set echo on

set linesize 132

set pagesize 66

spool c:\cprg250\module1\lab2output.txt

SELECT firstname, lastname FROM customers WHERE state = 'CA' ORDER BY lastname,firstname ASC;

SELECT title, category FROM books WHERE ((retail-cost) < 15) ORDER BY category,title;

SELECT title FROM books WHERE category='COMPUTER' and discount > 3;

SELECT firstname,lastname,region FROM customers WHERE region != 'N' and region != 'NW'and region !='NE' ORDER BY lastname DESC , firstname ASC;

SELECT lastname, firstname, region FROM customers WHERE region NOT in ('N','NW','NE') ORDER BY lastname DESC , firstname ASC;

spool off

set echo on
set linesize 132
set pagesize 66
spool c:\cprg250\module1\lab1output.txt
select title as "Book Title" from books;
select lastname, firstname, address, city, state, zip from customers;
select lastname || ',' || firstname || ',' || address || ',' || city || ','|| state || ','|| zip as "Customer Information" from customers;
select title, cost, retail,((retail - cost) / cost * 100) as "% Profit" from books;
select unique AuthorID as "Author ID" from bookauthor , books where books.isbn = bookauthor.isbn;
spool off