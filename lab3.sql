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