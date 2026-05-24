--Ερώτημα 1)

CREATE DATABASE new_personnel;
USE new_personnel;

CREATE TABLE DEPT(
DEPTNO INT(2) NOT NULL,
DNAME VARCHAR(14),
LOC VARCHAR(14),
PRIMARY KEY(DEPTNO));

DESCRIBE DEPT;

INSERT INTO DEPT VALUES(10, 'ACCOUNTING', 'ATHENS'),
(20, 'SALES', 'LONDON'),
(30, 'RESEARCH', 'ATHENS'),
(40, 'PAYROLL', 'LONDON');

SELECT * FROM DEPT;

CREATE TABLE EMP(
EMPNO INT(2) NOT NULL,
ENAME VARCHAR(10),
JOB VARCHAR(20),
HIREDATE DATE,
MGR INT(2),
SAL INT(4),
COMM INT(3),
DEPTNO INT(2),
PRIMARY KEY(EMPNO),
FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO));

DESCRIBE EMP;

INSERT INTO EMP VALUES(10, 'CODD', 'ANALYST', '1989-01-01', 15, 3000, NULL, 10),
(15, 'ELMASRI', 'ANALYST', '1995-05-02', 15, 1200, 150, 10),
(20, 'NAVATHE', 'SALESMAN', '1977-07-07', 20, 2000, NULL, 20),
(30, 'DATE', 'PROGRAMMER', '2004-05-04', 15, 1800, 200, 10);

SELECT * FROM EMP;

CREATE TABLE PROJ(
PROJ_CODE INT(3) NOT NULL,
DESCRIPTION VARCHAR(15),
PRIMARY KEY(PROJ_CODE));

DESCRIBE PROJ;

INSERT INTO PROJ VALUES(100, 'PAYROLL'),
(200, 'PERSONNEL'),
(300, 'SALES');

SELECT * FROM PROJ;

CREATE TABLE ASSIGN(
EMPNO INT(2) NOT NULL,
PROJ_CODE INT(3),
A_TIME INT(3),
PRIMARY KEY(EMPNO, PROJ_CODE),
FOREIGN KEY(EMPNO) REFERENCES EMP(EMPNO),
FOREIGN KEY(PROJ_CODE) REFERENCES PROJ(PROJ_CODE));

DESCRIBE ASSIGN;

INSERT INTO ASSIGN VALUES(10, 100, 40),
(10, 200, 60),
(15, 100, 100),
(20, 200, 100),
(30, 100, 100);

SELECT * FROM ASSIGN;

--Ερώτημα 2)

MariaDB [new_personnel]> show tables;
+-------------------------+
| Tables_in_new_personnel |
+-------------------------+
| assign                  |
| dept                    |
| emp                     |
| proj                    |
+-------------------------+

MariaDB [new_personnel]> describe dept;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| DEPTNO | int(2)      | NO   | PRI | NULL    |       |
| DNAME  | varchar(14) | YES  |     | NULL    |       |
| LOC    | varchar(14) | YES  |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+

MariaDB [new_personnel]> select * from dept;
+--------+------------+--------+
| DEPTNO | DNAME      | LOC    |
+--------+------------+--------+
|     10 | ACCOUNTING | ATHENS |
|     20 | SALES      | LONDON |
|     30 | RESEARCH   | ATHENS |
|     40 | PAYROLL    | LONDON |
+--------+------------+--------+

MariaDB [new_personnel]> describe emp;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| EMPNO    | int(2)      | NO   | PRI | NULL    |       |
| ENAME    | varchar(10) | YES  |     | NULL    |       |
| JOB      | varchar(20) | YES  |     | NULL    |       |
| HIREDATE | date        | YES  |     | NULL    |       |
| MGR      | int(2)      | YES  |     | NULL    |       |
| SAL      | int(4)      | YES  |     | NULL    |       |
| COMM     | int(3)      | YES  |     | NULL    |       |
| DEPTNO   | int(2)      | YES  | MUL | NULL    |       |
+----------+-------------+------+-----+---------+-------+

MariaDB [new_personnel]> select * from emp;
+-------+---------+------------+------------+------+------+------+--------+
| EMPNO | ENAME   | JOB        | HIREDATE   | MGR  | SAL  | COMM | DEPTNO |
+-------+---------+------------+------------+------+------+------+--------+
|    10 | CODD    | ANALYST    | 1989-01-01 |   15 | 3000 | NULL |     10 |
|    15 | ELMASRI | ANALYST    | 1995-05-02 |   15 | 1200 |  150 |     10 |
|    20 | NAVATHE | SALESMAN   | 1977-07-07 |   20 | 2000 | NULL |     20 |
|    30 | DATE    | PROGRAMMER | 2004-05-04 |   15 | 1800 |  200 |     10 |
+-------+---------+------------+------------+------+------+------+--------+

MariaDB [new_personnel]> describe proj;
+-------------+-------------+------+-----+---------+-------+
| Field       | Type        | Null | Key | Default | Extra |
+-------------+-------------+------+-----+---------+-------+
| PROJ_CODE   | int(3)      | NO   | PRI | NULL    |       |
| DESCRIPTION | varchar(15) | YES  |     | NULL    |       |
+-------------+-------------+------+-----+---------+-------+

MariaDB [new_personnel]> select * from proj;
+-----------+-------------+
| PROJ_CODE | DESCRIPTION |
+-----------+-------------+
|       100 | PAYROLL     |
|       200 | PERSONNEL   |
|       300 | SALES       |
+-----------+-------------+

MariaDB [new_personnel]> describe assign;
+-----------+--------+------+-----+---------+-------+
| Field     | Type   | Null | Key | Default | Extra |
+-----------+--------+------+-----+---------+-------+
| EMPNO     | int(2) | NO   | PRI | NULL    |       |
| PROJ_CODE | int(3) | NO   | PRI | NULL    |       |
| A_TIME    | int(3) | YES  |     | NULL    |       |
+-----------+--------+------+-----+---------+-------+

MariaDB [new_personnel]> select * from assign;
+-------+-----------+--------+
| EMPNO | PROJ_CODE | A_TIME |
+-------+-----------+--------+
|    10 |       100 |     40 |
|    10 |       200 |     60 |
|    15 |       100 |    100 |
|    20 |       200 |    100 |
|    30 |       100 |    100 |
+-------+-----------+--------+
