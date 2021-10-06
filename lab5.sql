set echo off
set verify off
set feedback off
set linesize 80
set pagesize 66
clear columns
columns cleared
clear breaks
breaks cleared
SET UNDERLINE OFF
spool c:\cprg250\module1\lab5.txt
COLUMN INITCAP(title) FORMAT A31 HEADING 'Book|Title|------------------------------'
COLUMN INITCAP(lastname) FORMAT A11 HEADING 'Last|Name|----------'
COLUMN INITCAP(firstname) FORMAT A11 HEADING 'First|Name|----------'
COLUMN cost FORMAT $9999.99 HEADING 'Book|Cost|----------'
TTITLE CENTER 'Customer / Title Information' SKIP CENTER 'Customer Order Evaluation' SKIP 2
BTITLE CENTER 'Internal Use Only'
BREAK ON INITCAP(title)
select INITCAP(title), INITCAP(lastname),INITCAP(firstname), cost
from books join orderitems using(isbn)
join orders using(order#) join customers using(customer#)
order by title;

set echo off
set verify off
set feedback off
set linesize 80
set pagesize 66
clear columns
clear breaks
SET UNDERLINE OFF
COLUMN initcap(name) FORMAT A23 HEADING 'Publisher|Name|----------------------'
COLUMN pubid FORMAT 99 HEADING 'ID|---'
COLUMN initcap(title) FORMAT A26 HEADING 'Book|Title|-------------------------'
COLUMN cost FORMAT $999.99 HEADING 'Book|Cost|----------'
TTITLE CENTER 'Author / Title Information' SKIP CENTER 'Author Book Cost Evaluation' SKIP 2
BTITLE CENTER 'Internal Use Only'
BREAK ON initcap(name) ON pubid SKIP 1 ON report
COMPUTE SUM LABEL 'Total Cost:' of bcost on initcap(name)
COMPUTE SUM LABEL 'Grand Total Cost' of bcost on report
COLUMN bcost FORMAT $9,990.00 HEADING 'Book|Cost|----------'
select initcap(name), pubid, initcap(title), (cost) bcost
from books join publisher using(pubid)
order by 1,3;

spool off



