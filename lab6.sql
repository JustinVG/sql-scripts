set echo on

set linesize 132

set pagesize 66

spool c:\cprg250\module1\lab6.txt

select firstname, lastname from customers
  where state=
               (select state from customers
                where firstname='LEILA')
					and lastname!='SMITH';
					
select DISTINCT c.firstname, c.lastname, b.title, b.retail, (select avg(retail) from books) Avg
from books b join orderitems oi on(b.isbn=oi.isbn) join orders o on(oi.order#=o.order#) join customers c on(o.customer#=c.customer#)
where b.retail>(select avg(retail) from books)
order by 2,3;


select (fname || ' ' || lname) "Author", max(pubdate)          
from books b join bookauthor ba using (isbn) join author using (authorid)
group by (fname || ' ' || lname);



select firstname, lastname, count(order#)
from customers join orders using (customer#)
group by firstname, lastname
order by count(order#) desc, lastname asc
offset 10 rows fetch next 4 rows only;


select DISTINCT customer#, order#, sum(paideach*quantity) "Order Value"
from orders join orderitems using (order#)
group by order#, customer#
order by customer# asc, order# asc;



spool off