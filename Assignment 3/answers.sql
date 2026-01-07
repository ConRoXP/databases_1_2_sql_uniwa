-- 1)

select ename, deptno
from emp
where deptno= 10
order by comm;

+---------+--------+
| ename   | deptno |
+---------+--------+
| CODD    |     10 |
| ELMASRI |     10 |
| DATE    |     10 |
+---------+--------+

-- 2)

select ename, job, sal
from emp
order by job asc, sal desc;

+---------+------------+------+
| ename   | job        | sal  |
+---------+------------+------+
| CODD    | ANALYST    | 3000 |
| ELMASRI | ANALYST    | 1200 |
| DATE    | PROGRAMMER | 1800 |
| NAVATHE | SALESMAN   | 2000 |
+---------+------------+------+

-- 3)

select deptno,
avg(sal) as 'ΜΕΣΟΣ ΜΙΣΘΟΣ'
from emp
having count(*)>= 1;

+--------+--------------+
| deptno | ΜΕΣΟΣ ΜΙΣΘΟΣ |
+--------+--------------+
|     10 |    2000.0000 |
|     20 |    2000.0000 |
+--------+--------------+

-- 4)
select deptno as 'ΤΜΗΜΑ',
avg(timestampdiff(year, hiredate, curdate())) as 'ΠΡΟΫΠΗΡΕΣΙΑ'
from emp
group by deptno;

+-------+-------------+
| ΤΜΗΜΑ | ΠΡΟΫΠΗΡΕΣΙΑ |
+-------+-------------+
|    10 |     29.0000 |
|    20 |     47.0000 |
+-------+-------------+

-- 5)

select proj.description as 'pname',
emp.ename,
emp.job
from assign
join emp on assign.empno= emp.empno
join proj on assign.proj_code= proj.proj_code
order by proj.description, emp.job;

+-----------+---------+------------+
| pname     | ename   | job        |
+-----------+---------+------------+
| PAYROLL   | CODD    | ANALYST    |
| PAYROLL   | ELMASRI | ANALYST    |
| PAYROLL   | DATE    | PROGRAMMER |
| PERSONNEL | CODD    | ANALYST    |
| PERSONNEL | NAVATHE | SALESMAN   |
+-----------+---------+------------+

-- 6)

select d.dname as Department,
m.ename as Manager,
e.ename as Employee
from emp e
join emp m on e.mgr= m.empno
join dept d on e.deptno= d.deptno
order by d.dname, e.ename;

+------------+---------+----------+
| Department | Manager | Employee |
+------------+---------+----------+
| ACCOUNTING | ELMASRI | CODD     |
| ACCOUNTING | ELMASRI | DATE     |
| ACCOUNTING | ELMASRI | ELMASRI  |
| SALES      | NAVATHE | NAVATHE  |
+------------+---------+----------+

-- 7)

select e.ename,
e.job,
d.loc
from emp e
join dept d on e.deptno= d.deptno
where d.dname= 'RESEARCH';

Empty set (0.001 sec)

-- Δεν υπάρχει υπάλληλος στο τμήμα Research (DEPTNO= 30).

-- 8)

select e.ename
from assign a
join emp e on a.empno= e.empno
join proj p on a.proj_code= p.proj_code
where p.description= 'PAYROLL' and a.a_time > 50;

+---------+
| ename   |
+---------+
| ELMASRI |
| DATE    |
+---------+
