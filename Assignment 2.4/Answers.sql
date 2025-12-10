--Ερώτημα 1
# mysql -u root
Welcome to the MariaDB monitor.

--Ερωτήματα 2 & 3
MariaDB [(none)]> use personnel;
Database changed

--Ερωτήματα 4
MariaDB [personnel]> delimiter //
MariaDB [personnel]> create trigger dept_update
    -> before update on dept
    -> for each row
    -> begin
    -> set new.dname = upper(new.dname);
    -> end;
    -> //
Query OK, 0 rows affected (0.005 sec)

Δοκιμή:
MariaDB [personnel]> update dept set dname= 'Operations' where (deptno=70);
Query OK, 1 row affected (0.002 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [personnel]> select * from dept;
+--------+------------+--------+
| DEPTNO | DNAME      | LOC    |
+--------+------------+--------+
|     50 | SALES      | ATHENS |
|     60 | ACCOUNTING | ATHENS |
|     70 | OPERATIONS | VOLOS  |
+--------+------------+--------+

--Ερώτημα 5
MariaDB [personnel]> alter table dept add (no_of_employees int);
Query OK, 0 rows affected (0.008 sec)
Records: 0  Duplicates: 0  Warnings: 0

--Ερώτημα 6
MariaDB [personnel]> update dept
    -> set no_of_employees=
    -> (select count(*) from emp where emp.deptno=dept.deptno);
Query OK, 3 rows affected (0.001 sec)
Rows matched: 3  Changed: 3  Warnings: 0

MariaDB [personnel]> select * from dept;
+--------+------------+--------+-----------------+
| DEPTNO | DNAME      | LOC    | no_of_employees |
+--------+------------+--------+-----------------+
|     50 | SALES      | ATHENS |               3 |
|     60 | ACCOUNTING | ATHENS |               1 |
|     70 | OPERATIONS | VOLOS  |               0 |
+--------+------------+--------+-----------------+

--Ερώτημα 7
MariaDB [personnel]> delimiter //
MariaDB [personnel]> create trigger emp_insert
    -> after insert on emp
    -> for each row
    -> begin
    -> update dept
    -> set no_of_employees= ifnull(no_of_employees, 0)+1
    -> where deptno= new.deptno;
    -> end;
    -> //

--Ερώτημα 8
Δοκιμή:

MariaDB [personnel]> insert into emp (values(7985, 'CLARKE', 300, 70, NULL));
Query OK, 1 row affected (0.002 sec)

MariaDB [personnel]> select * from emp;
+-------+---------+-------+--------+--------+
| EMPNO | NAME    | JOBNO | DEPTNO | COMM   |
+-------+---------+-------+--------+--------+
|    10 | CODD    |   100 |     50 |   NULL |
|    20 | NAVATHE |   200 |     50 | 450.00 |
|    30 | ELMASRI |   300 |     60 |   NULL |
|    40 | DATE    |   100 |     50 |   NULL |
|  7985 | CLARKE  |   300 |     70 |   NULL |
+-------+---------+-------+--------+--------+

MariaDB [personnel]> select * from dept;
+--------+------------+--------+-----------------+
| DEPTNO | DNAME      | LOC    | no_of_employees |
+--------+------------+--------+-----------------+
|     50 | SALES      | ATHENS |               3 |
|     60 | ACCOUNTING | ATHENS |               1 |
|     70 | OPERATIONS | VOLOS  |               1 |
+--------+------------+--------+-----------------+

--Ερώτημα 9
null

--Ερώτημα 10
MariaDB [personnel]> create trigger emp_delete
    -> after delete on emp
    -> for each row
    -> begin
    -> update dept
    -> set no_of_employees= ifnull(no_of_employees, 0)-1
    -> where deptno= old.deptno;
    -> end;
    -> //
Query OK, 0 rows affected (0.005 sec)

-Επεξήγηση:
O trigger ενεργοποιείται μόνο αφού διαγραφεί κάποια εγγραφή
από τον πίνακα emp και εκτελείται για κάθε γραμμή που διαγράφεται.
Μειώνει το πλήθος των υπαλλήλων του αντίστοιχου τμήματος στον dept κατά 1,
με έλεγχο για NULL.
Χρησιμοποιούμε old.deptno γιατί στο delete δεν υπάρχει new.

-Δοκιμή:

Πριν:
MariaDB [personnel]> select deptno, no_of_employees from dept;
+--------+-----------------+
| deptno | no_of_employees |
+--------+-----------------+
|     50 |               3 |
|     60 |               1 |
|     70 |               1 |
+--------+-----------------+

Αλλαγή:
MariaDB [personnel]> delete from emp where empno = 7985;
Query OK, 1 row affected (0.001 sec)

Μετά:
MariaDB [personnel]> select deptno, no_of_employees from dept;
+--------+-----------------+
| deptno | no_of_employees |
+--------+-----------------+
|     50 |               3 |
|     60 |               1 |
|     70 |               0 |
+--------+-----------------+

--Ερώτημα 11
MariaDB [personnel]> delimiter //
MariaDB [personnel]> create trigger emp_update
    -> after update on emp
    -> for each row
    -> begin
    -> if old.deptno <> new.deptno then
    -> update dept
    -> set no_of_employees= ifnull(no_of_employees, 0)-1
    -> where deptno= old.deptno;
    -> update dept
    -> set no_of_employees= ifnull(no_of_employees, 0)+1
    -> where deptno= new.deptno;
    -> end if;
    -> end;
    -> //
Query OK, 0 rows affected (0.005 sec)

-Επεξήγηση:
Ο trigger ενεργοποιείται μετά από κάθε update στον πίνακα emp,
και εκτελείται για κάθε εγγραφή που αλλάζει.
Ελέγχει αν ο υπάλληλος άλλαξε τμήμα, αν όχι δεν κάνει τίποτα.
Αλλιώς ενημερώνουμε τα αντίστοιχα τμήματα, μειώνοντας το πλήθος του τμήματος
από το οποίο έφυγε, και αυξάνοντας αντίστοιχα το τμήμα στο οποίο πήγε.

-Δοκιμή:

Πριν:
MariaDB [personnel]> select deptno, no_of_employees from dept;
+--------+-----------------+
| deptno | no_of_employees |
+--------+-----------------+
|     50 |               3 |
|     60 |               1 |
|     70 |               0 |
+--------+-----------------+

Αλλαγή:
MariaDB [personnel]> update emp
    -> set deptno= 70
    -> where empno= 20;
Query OK, 1 row affected (0.001 sec)
Rows matched: 1  Changed: 1  Warnings: 0

Μετά:
MariaDB [personnel]> select deptno, no_of_employees from dept;
+--------+-----------------+
| deptno | no_of_employees |
+--------+-----------------+
|     50 |               2 |
|     60 |               1 |
|     70 |               1 |
+--------+-----------------+

--Ερώτημα 12
MariaDB [personnel]> describe information_schema.triggers;
+----------------------------+---------------+------+-----+---------+-------+
| Field                      | Type          | Null | Key | Default | Extra |
+----------------------------+---------------+------+-----+---------+-------+
| TRIGGER_CATALOG            | varchar(512)  | NO   |     | NULL    |       |
| TRIGGER_SCHEMA             | varchar(64)   | NO   |     | NULL    |       |
| TRIGGER_NAME               | varchar(64)   | NO   |     | NULL    |       |
| EVENT_MANIPULATION         | varchar(6)    | NO   |     | NULL    |       |
| EVENT_OBJECT_CATALOG       | varchar(512)  | NO   |     | NULL    |       |
| EVENT_OBJECT_SCHEMA        | varchar(64)   | NO   |     | NULL    |       |
| EVENT_OBJECT_TABLE         | varchar(64)   | NO   |     | NULL    |       |
| ACTION_ORDER               | bigint(4)     | NO   |     | NULL    |       |
| ACTION_CONDITION           | longtext      | YES  |     | NULL    |       |
| ACTION_STATEMENT           | longtext      | NO   |     | NULL    |       |
| ACTION_ORIENTATION         | varchar(9)    | NO   |     | NULL    |       |
| ACTION_TIMING              | varchar(6)    | NO   |     | NULL    |       |
| ACTION_REFERENCE_OLD_TABLE | varchar(64)   | YES  |     | NULL    |       |
| ACTION_REFERENCE_NEW_TABLE | varchar(64)   | YES  |     | NULL    |       |
| ACTION_REFERENCE_OLD_ROW   | varchar(3)    | NO   |     | NULL    |       |
| ACTION_REFERENCE_NEW_ROW   | varchar(3)    | NO   |     | NULL    |       |
| CREATED                    | datetime(2)   | YES  |     | NULL    |       |
| SQL_MODE                   | varchar(8192) | NO   |     | NULL    |       |
| DEFINER                    | varchar(189)  | NO   |     | NULL    |       |
| CHARACTER_SET_CLIENT       | varchar(32)   | NO   |     | NULL    |       |
| COLLATION_CONNECTION       | varchar(32)   | NO   |     | NULL    |       |
| DATABASE_COLLATION         | varchar(32)   | NO   |     | NULL    |       |
+----------------------------+---------------+------+-----+---------+-------+

MariaDB [personnel]> select trigger_name, event_manipulation, trigger_schema
    -> from information_schema.triggers
    -> where trigger_schema= 'personnel'
    -> order by trigger_name;
+--------------+--------------------+----------------+
| trigger_name | event_manipulation | trigger_schema |
+--------------+--------------------+----------------+
| dept_update  | UPDATE             | personnel      |
| emp_delete   | DELETE             | personnel      |
| emp_insert   | INSERT             | personnel      |
| emp_update   | UPDATE             | personnel      |
+--------------+--------------------+----------------+

--Ερώτημα 13
MariaDB [personnel]> drop trigger dept_update;
Query OK, 0 rows affected (0.002 sec)

MariaDB [personnel]> drop trigger emp_delete;
Query OK, 0 rows affected (0.005 sec)

MariaDB [personnel]> drop trigger emp_delete;
Query OK, 0 rows affected (0.005 sec)

MariaDB [personnel]> drop trigger emp_update;
Query OK, 0 rows affected (0.002 sec)

MariaDB [personnel]> select trigger_name, event_manipulation, trigger_schema
    -> from information_schema.triggers
    -> where trigger_schema= 'personnel';
Empty set (0.018 sec)