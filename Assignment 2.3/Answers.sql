--Ερώτημα 1
# mysql -u root
Welcome to the MariaDB monitor.

--Ερωτήματα 2 & 3
MariaDB [(none)]> use personnel;
Database changed

--Ερώτημα 4
MariaDB [personnel]> create view EMP_VIEW(e_ID, e_Name, e_Job, e_Dept, e_Comm)
    -> as select empno, name, jobno, deptno, comm from emp;
Query OK, 0 rows affected (0.005 sec)

--Ερώτημα 5
MariaDB [personnel]> select * from emp_view;
+------+---------+-------+--------+--------+
| e_ID | e_Name  | e_Job | e_Dept | e_Comm |
+------+---------+-------+--------+--------+
|   10 | CODD    |   100 |     50 |   NULL |
|   20 | NAVATHE |   200 |     50 | 450.00 |
|   30 | ELMASRI |   300 |     60 |   NULL |
|   40 | DATE    |   100 |     50 |   NULL |
+------+---------+-------+--------+--------+

--Ερώτημα 6
insert into EMP(EMPNO, NAME, JOBNO, DEPTNO, COMM) values (90, 'CLARKE', 100, 50, NULL);

MariaDB [personnel]> select * from emp;
+-------+---------+-------+--------+--------+
| empno | name    | jobno | deptno | comm   |
+-------+---------+-------+--------+--------+
|    10 | CODD    |   100 |     50 |   NULL |
|    20 | NAVATHE |   200 |     50 | 450.00 |
|    30 | ELMASRI |   300 |     60 |   NULL |
|    40 | DATE    |   100 |     50 |   NULL |
|    90 | CLARKE  |   100 |     50 |   NULL |
+-------+---------+-------+--------+--------+

MariaDB [personnel]> select * from emp_view;
+------+---------+-------+--------+--------+
| e_ID | e_Name  | e_Job | e_Dept | e_Comm |
+------+---------+-------+--------+--------+
|   10 | CODD    |   100 |     50 |   NULL |
|   20 | NAVATHE |   200 |     50 | 450.00 |
|   30 | ELMASRI |   300 |     60 |   NULL |
|   40 | DATE    |   100 |     50 |   NULL |
|   90 | CLARKE  |   100 |     50 |   NULL |
+------+---------+-------+--------+--------+

--Ερώτημα 7
MariaDB [personnel]> insert into EMP_VIEW(e_ID, e_Name, e_Job, e_Dept, e_Comm)
    -> values (100, 'adams', 100, 60, null);
Query OK, 1 row affected (0.002 sec)

MariaDB [personnel]> update EMP_VIEW set e_Job=200 where e_ID=100;
Query OK, 1 row affected (0.002 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [personnel]> select * from emp;
+-------+---------+-------+--------+--------+
| empno | name    | jobno | deptno | comm   |
+-------+---------+-------+--------+--------+
|    10 | CODD    |   100 |     50 |   NULL |
|    20 | NAVATHE |   200 |     50 | 450.00 |
|    30 | ELMASRI |   300 |     60 |   NULL |
|    40 | DATE    |   100 |     50 |   NULL |
|    90 | CLARKE  |   100 |     50 |   NULL |
|   100 | adams   |   200 |     60 |   NULL |
+-------+---------+-------+--------+--------+

MariaDB [personnel]> select * from emp_view;
+------+---------+-------+--------+--------+
| e_ID | e_Name  | e_Job | e_Dept | e_Comm |
+------+---------+-------+--------+--------+
|   10 | CODD    |   100 |     50 |   NULL |
|   20 | NAVATHE |   200 |     50 | 450.00 |
|   30 | ELMASRI |   300 |     60 |   NULL |
|   40 | DATE    |   100 |     50 |   NULL |
|   90 | CLARKE  |   100 |     50 |   NULL |
|  100 | adams   |   200 |     60 |   NULL |
+------+---------+-------+--------+--------+

--Ερώτημα 8
MariaDB [personnel]> create view EMP_ON_SALES(e_ID, e_Name, e_Job, e_Dept, e_Comm) as
    -> select EMPNO, NAME, JOBNO, DEPTNO, COMM from EMP
    -> where DEPTNO in (select DEPTNO from DEPT where DNAME='SALES');
Query OK, 0 rows affected (0.003 sec)

MariaDB [personnel]> select * from emp;
+-------+---------+-------+--------+--------+
| empno | name    | jobno | deptno | comm   |
+-------+---------+-------+--------+--------+
|    10 | CODD    |   100 |     50 |   NULL |
|    20 | NAVATHE |   200 |     50 | 450.00 |
|    30 | ELMASRI |   300 |     60 |   NULL |
|    40 | DATE    |   100 |     50 |   NULL |
|    90 | CLARKE  |   100 |     50 |   NULL |
|   100 | adams   |   200 |     60 |   NULL |
+-------+---------+-------+--------+--------+

MariaDB [personnel]> select * from emp_on_sales;
+------+---------+-------+--------+--------+
| e_ID | e_Name  | e_Job | e_Dept | e_Comm |
+------+---------+-------+--------+--------+
|   10 | CODD    |   100 |     50 |   NULL |
|   20 | NAVATHE |   200 |     50 | 450.00 |
|   40 | DATE    |   100 |     50 |   NULL |
|   90 | CLARKE  |   100 |     50 |   NULL |
+------+---------+-------+--------+--------+

--Ερώτημα 9
MariaDB [personnel]> insert into EMP(EMPNO, NAME, JOBNO, DEPTNO, COMM) values (110, 'NAVATHE', 100, 60, NULL);
Query OK, 1 row affected (0.002 sec)

--Ερώτημα 10
Ναι, εμφανίζονται:

MariaDB [personnel]> select * from emp;
+-------+---------+-------+--------+--------+
| empno | name    | jobno | deptno | comm   |
+-------+---------+-------+--------+--------+
|    10 | CODD    |   100 |     50 |   NULL |
|    20 | NAVATHE |   200 |     50 | 450.00 |
|    30 | ELMASRI |   300 |     60 |   NULL |
|    40 | DATE    |   100 |     50 |   NULL |
|    90 | CLARKE  |   100 |     50 |   NULL |
|   100 | adams   |   200 |     60 |   NULL |
|   110 | NAVATHE |   100 |     60 |   NULL |
+-------+---------+-------+--------+--------+

--Ερώτημα 11
Όχι, δεν εμφανίζονται:

MariaDB [personnel]> select * from emp_on_sales;
+------+---------+-------+--------+--------+
| e_ID | e_Name  | e_Job | e_Dept | e_Comm |
+------+---------+-------+--------+--------+
|   10 | CODD    |   100 |     50 |   NULL |
|   20 | NAVATHE |   200 |     50 | 450.00 |
|   40 | DATE    |   100 |     50 |   NULL |
|   90 | CLARKE  |   100 |     50 |   NULL |
+------+---------+-------+--------+--------+

--Ερώτημα 12
MariaDB [personnel]> insert into EMP_ON_SALES(e_ID, e_Name, e_Job, e_Dept, e_Comm)
    -> values (120, 'ELMASRI', 100, 60, NULL);
Query OK, 1 row affected (0.002 sec)

--Ερώτημα 13
Ναι, εμφανίζονται:

MariaDB [personnel]> select * from emp;
+-------+---------+-------+--------+--------+
| empno | name    | jobno | deptno | comm   |
+-------+---------+-------+--------+--------+
|    10 | CODD    |   100 |     50 |   NULL |
|    20 | NAVATHE |   200 |     50 | 450.00 |
|    30 | ELMASRI |   300 |     60 |   NULL |
|    40 | DATE    |   100 |     50 |   NULL |
|    90 | CLARKE  |   100 |     50 |   NULL |
|   100 | adams   |   200 |     60 |   NULL |
|   110 | NAVATHE |   100 |     60 |   NULL |
|   120 | ELMASRI |   100 |     60 |   NULL |
+-------+---------+-------+--------+--------+

--Ερώτημα 14
Όχι, δεν εμφανίζονται:

MariaDB [personnel]> select * from emp_on_sales;
+------+---------+-------+--------+--------+
| e_ID | e_Name  | e_Job | e_Dept | e_Comm |
+------+---------+-------+--------+--------+
|   10 | CODD    |   100 |     50 |   NULL |
|   20 | NAVATHE |   200 |     50 | 450.00 |
|   40 | DATE    |   100 |     50 |   NULL |
|   90 | CLARKE  |   100 |     50 |   NULL |
+------+---------+-------+--------+--------+

--Ερώτημα 15
MariaDB [personnel]> create view EMP_ON_SALES_S(e_ID, e_Name, e_Job, e_Dept, e_Comm)
    -> as
    -> select EMPNO, NAME, JOBNO, DEPTNO, COMM from EMP
    -> where DEPTNO in(select DEPTNO from DEPT where DNAME='SALES') with check option;
Query OK, 0 rows affected (0.002 sec)

--Ερώτημα 16
MariaDB [personnel]> insert into EMP_ON_SALES_S(e_ID, e_Name, e_Job, e_Dept, e_Comm)
    -> values (130, 'DATE', 100, 60, NULL);
ERROR 1369 (44000): CHECK OPTION failed `personnel`.`emp_on_sales_s`

--Ερώτημα 17
Όχι, δεν εμφανίζονται:

MariaDB [personnel]> select * from emp;
+-------+---------+-------+--------+--------+
| empno | name    | jobno | deptno | comm   |
+-------+---------+-------+--------+--------+
|    10 | CODD    |   100 |     50 |   NULL |
|    20 | NAVATHE |   200 |     50 | 450.00 |
|    30 | ELMASRI |   300 |     60 |   NULL |
|    40 | DATE    |   100 |     50 |   NULL |
|    90 | CLARKE  |   100 |     50 |   NULL |
|   100 | adams   |   200 |     60 |   NULL |
|   110 | NAVATHE |   100 |     60 |   NULL |
|   120 | ELMASRI |   100 |     60 |   NULL |
+-------+---------+-------+--------+--------+

--Ερώτημα 18
Όχι, δεν εμφανίζονται:

MariaDB [personnel]> select * from emp_on_sales_s;
+------+---------+-------+--------+--------+
| e_ID | e_Name  | e_Job | e_Dept | e_Comm |
+------+---------+-------+--------+--------+
|   10 | CODD    |   100 |     50 |   NULL |
|   20 | NAVATHE |   200 |     50 | 450.00 |
|   40 | DATE    |   100 |     50 |   NULL |
|   90 | CLARKE  |   100 |     50 |   NULL |
+------+---------+-------+--------+--------+

--Ερώτημα 19
MariaDB [personnel]> create view EMP_DISTINCT_NAMES (NAME) as select distinct NAME from EMP order by NAME;
Query OK, 0 rows affected (0.002 sec)

--Ερώτημα 20
Η EMP_DISTINCT_NAMES είναι μη ενημερώσιμη όψηQ

MariaDB [personnel]> insert into EMP_DISTINCT_NAMES values ('GREEN');
ERROR 1471 (HY000): The target table EMP_DISTINCT_NAMES of the INSERT is not insertable-into

--Ερωτήματα 21 & 22
1)
MariaDB [personnel]> create view GROUP_EMP(DEPT, COUNT_EMP, AVG_COMM) as select DEPTNO, count(*), avg(COMM) from
    -> EMP group by DEPTNO;
Query OK, 0 rows affected (0.002 sec)

Mη ενημερώσιμη όψη:

MariaDB [personnel]> insert into GROUP_EMP values (80, 2, 100);
ERROR 1471 (HY000): The target table GROUP_EMP of the INSERT is not insertable-into

2)
MariaDB [personnel]> insert into GROUP_EMP values (80, 2, 100);
ERROR 1471 (HY000): The target table GROUP_EMP of the INSERT is not insertable-into
MariaDB [personnel]> create view EMP_DEPT_VIEW(EMPNO, NAME, JOBNO, DEPTNO, DNAME)
    -> as select EMPNO, NAME, JOBNO, EMP.DEPTNO, DNAME
    -> from EMP inner join DEPT on EMP.DEPTNO=DEPT.DEPTNO;
Query OK, 0 rows affected (0.002 sec)

Mη ενημερώσιμη όψη:

MariaDB [personnel]> insert into EMP_DEPT_VIEW
    -> VALUES (90, 'TEST', 100, 50, 'SALES');
ERROR 1394 (HY000): Can not insert into join view 'personnel.emp_dept_view' without fields list

3)
MariaDB [personnel]> create view new_EMP_DEPT_VIEW(EMPNO, NAME, JOBNO, DEPTNO)
    -> as select EMPNO, NAME, JOBNO, EMP.DEPTNO
    -> from EMP inner join DEPT on EMP.DEPTNO=DEPT.DEPTNO;
Query OK, 0 rows affected (0.003 sec)

Mη ενημερώσιμη όψη:

MariaDB [personnel]> insert into new_EMP_DEPT_VIEW
    -> VALUES (100, 'TEST3', 200, 60);
ERROR 1394 (HY000): Can not insert into join view 'personnel.new_emp_dept_view' without fields list