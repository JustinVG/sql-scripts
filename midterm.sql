set echo on
set linesize 132
set pagesize 66
clear columns
clear breaks

spool c:\cprg250\module1\midterm.txt

--Q2
select firstname , surname , course_title , credits
from course c join expertise e using (course_code) join faculty f using (employee_id)
where course_code like 'CSYS%';

--Q3

select course_title
from course
where prerequisite is null
order by course_title DESC;

--Q4
select to_char(avg(grade), 99.99) "average grade"
from course_registration 
where grade is not null

select unit, sum(salary)
from faculty
group by unit
having sum(salary) >= 50000 and unit is not null;

--Q5
select firstname, surname, (select avg(grade)
								from course_registration) "avg"
from student join course_registration using (student_id)
where grade < (select avg(grade)
					from course_registration)
					order by 1,2 desc;

--Q6
set echo off
set verify off
set feedback off
set linesize 80
set pagesize 66
clear columns
clear breaks
clear computes

TTITLE CENTER 'Class Capacity Report' SKIP 1
break on course_code on report
COMPUTE SUM LABEL 'Course Cap.' of cvalue on course_code
COMPUTE SUM LABEL 'Grand Cap' of cvalue on report

COLUMN course_code FORMAT A10 HEADING 'Course|Code'
COLUMN semester FORMAT A10 HEADING 'Semester'eading 
column cvalue format 999 'Capacity | Value'
select course_code, semester, sum(capacity)
from class_section
group by course_code, semester
having sum(capacity) >= 75
order by 1;
spool off
set echo on
clear break
clear column
clear compute 
