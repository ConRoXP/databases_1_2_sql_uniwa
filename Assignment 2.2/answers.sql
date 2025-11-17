--Ερώτημα 1:
Ερώτημα 1.png

--Ερώτημα 2:
MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| new_personnel      |
| performance_schema |
| phpmyadmin         |
| test               |
+--------------------+

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| new_personnel      |
| performance_schema |
| personnel          |
| phpmyadmin         |
| test               |
+--------------------+

--Ερώτημα 3:
MariaDB [(none)]> use personnel;
Database changed
MariaDB [personnel]>

--Ερώτημα 4:
MariaDB [personnel]> show tables;
Empty set (0.001 sec)

--Ερώτημα 5:
create table dept(
deptno numeric(2),
dname varchar(24),
loc char(23));

MariaDB [personnel]> describe dept;
+--------+--------------+------+-----+---------+-------+
| Field  | Type         | Null | Key | Default | Extra |
+--------+--------------+------+-----+---------+-------+
| deptno | decimal(2,0) | YES  |     | NULL    |       |
| dname  | varchar(24)  | YES  |     | NULL    |       |
| loc    | char(23)     | YES  |     | NULL    |       |
+--------+--------------+------+-----+---------+-------+

create table job(
jobcode numeric(3),
job_descr varchar(24),
sal numeric(10,2));

MariaDB [personnel]> describe job;
+-----------+---------------+------+-----+---------+-------+
| Field     | Type          | Null | Key | Default | Extra |
+-----------+---------------+------+-----+---------+-------+
| jobcode   | decimal(3,0)  | YES  |     | NULL    |       |
| job_descr | varchar(24)   | YES  |     | NULL    |       |
| sal       | decimal(10,2) | YES  |     | NULL    |       |
+-----------+---------------+------+-----+---------+-------+

create table emp(
empno numeric(4),
name varchar(24),
jobno numeric(3),
deptno numeric(2),
comm numeric(10,2));

MariaDB [personnel]> describe emp;
+--------+---------------+------+-----+---------+-------+
| Field  | Type          | Null | Key | Default | Extra |
+--------+---------------+------+-----+---------+-------+
| empno  | decimal(4,0)  | YES  |     | NULL    |       |
| name   | varchar(24)   | YES  |     | NULL    |       |
| jobno  | decimal(3,0)  | YES  |     | NULL    |       |
| deptno | decimal(2,0)  | YES  |     | NULL    |       |
| comm   | decimal(10,2) | YES  |     | NULL    |       |
+--------+---------------+------+-----+---------+-------+

--Ερώτημα 6:
create table emp(
empno numeric(4),
name varchar(24),
jobno numeric(3),
deptno numeric(2),
comm numeric(10,2));

MariaDB [personnel]> select * from dept;
+--------+------------+--------+
| deptno | dname      | loc    |
+--------+------------+--------+
|     50 | SALES      | ATHENS |
|     60 | ACCOUNTING | ATHENS |
|     70 | PAYROL     | VOLOS  |
+--------+------------+--------+

insert into job values
(100, 'SALESMAN', 2000),
(200, 'ANALYST', 2000),
(300, 'DBA', 3000);

MariaDB [personnel]> select * from job;
+---------+-----------+---------+
| jobcode | job_descr | sal     |
+---------+-----------+---------+
|     100 | SALESMAN  | 2000.00 |
|     200 | ANALYST   | 2000.00 |
|     300 | DBA       | 3000.00 |
+---------+-----------+---------+

insert into emp values
(10, 'CODD', 100, 50, NULL),
(20, 'NAVATHE', 200, 50, 450),
(30, 'ELMASRI', 300, 60, NULL),
(40, 'DATE', 100, 50, NULL);

MariaDB [personnel]> select * from emp;
+-------+---------+-------+--------+--------+
| empno | name    | jobno | deptno | comm   |
+-------+---------+-------+--------+--------+
|    10 | CODD    |   100 |     50 |   NULL |
|    20 | NAVATHE |   200 |     50 | 450.00 |
|    30 | ELMASRI |   300 |     60 |   NULL |
|    40 | DATE    |   100 |     50 |   NULL |
+-------+---------+-------+--------+--------+

--Ερώτημα 7:
alter table emp
add column hiredate date;

MariaDB [personnel]> describe emp;
+----------+---------------+------+-----+---------+-------+
| Field    | Type          | Null | Key | Default | Extra |
+----------+---------------+------+-----+---------+-------+
| empno    | decimal(4,0)  | YES  |     | NULL    |       |
| name     | varchar(24)   | YES  |     | NULL    |       |
| jobno    | decimal(3,0)  | YES  |     | NULL    |       |
| deptno   | decimal(2,0)  | YES  |     | NULL    |       |
| comm     | decimal(10,2) | YES  |     | NULL    |       |
| hiredate | date          | YES  |     | NULL    |       |
+----------+---------------+------+-----+---------+-------+

--Ερώτημα 8:
update emp set hiredate='2001-01-10' where empno=10;
update emp set hiredate='1999-02-25' where empno=20;
update emp set hiredate='1999-02-25' where empno=20;
update emp set hiredate='1999-02-25' where empno=20;

MariaDB [personnel]> select * from emp;
+-------+---------+-------+--------+--------+------------+
| empno | name    | jobno | deptno | comm   | hiredate   |
+-------+---------+-------+--------+--------+------------+
|    10 | CODD    |   100 |     50 |   NULL | 2001-01-10 |
|    20 | NAVATHE |   200 |     50 | 450.00 | 1999-02-25 |
|    30 | ELMASRI |   300 |     60 |   NULL | 2000-03-17 |
|    40 | DATE    |   100 |     50 |   NULL | 1989-06-07 |
+-------+---------+-------+--------+--------+------------+

--Ερώτημα 9:
alter table job
modify column job_descr varchar(30);

MariaDB [personnel]> describe job;
+-----------+---------------+------+-----+---------+-------+
| Field     | Type          | Null | Key | Default | Extra |
+-----------+---------------+------+-----+---------+-------+
| jobcode   | decimal(3,0)  | YES  |     | NULL    |       |
| job_descr | varchar(30)   | YES  |     | NULL    |       |
| sal       | decimal(10,2) | YES  |     | NULL    |       |
+-----------+---------------+------+-----+---------+-------+

--Ερώτημα 10:
alter table dept
drop column loc;

MariaDB [personnel]> describe dept;
+--------+--------------+------+-----+---------+-------+
| Field  | Type         | Null | Key | Default | Extra |
+--------+--------------+------+-----+---------+-------+
| deptno | decimal(2,0) | YES  |     | NULL    |       |
| dname  | varchar(24)  | YES  |     | NULL    |       |
+--------+--------------+------+-----+---------+-------+

--Ερώτημα 11:
alter table dept
change column dname dept_name varchar(25);

MariaDB [personnel]> describe dept;
+-----------+--------------+------+-----+---------+-------+
| Field     | Type         | Null | Key | Default | Extra |
+-----------+--------------+------+-----+---------+-------+
| deptno    | decimal(2,0) | YES  |     | NULL    |       |
| dept_name | varchar(25)  | YES  |     | NULL    |       |
+-----------+--------------+------+-----+---------+-------+

--Ερώτημα 12:
alter table dept
add constraint pk_DEPTNO
primary key (deptno);

MariaDB [personnel]> describe dept;
+-----------+--------------+------+-----+---------+-------+
| Field     | Type         | Null | Key | Default | Extra |
+-----------+--------------+------+-----+---------+-------+
| deptno    | decimal(2,0) | NO   | PRI | NULL    |       |
| dept_name | varchar(25)  | YES  |     | NULL    |       |
+-----------+--------------+------+-----+---------+-------+

--Ερώτημα 13:
alter table dept
drop primary key;

MariaDB [personnel]> describe dept;
+-----------+--------------+------+-----+---------+-------+
| Field     | Type         | Null | Key | Default | Extra |
+-----------+--------------+------+-----+---------+-------+
| deptno    | decimal(2,0) | NO   |     | NULL    |       |
| dept_name | varchar(25)  | YES  |     | NULL    |       |
+-----------+--------------+------+-----+---------+-------+

MariaDB [personnel]> show create table dept;
+-------+-----------------------------------------------------------+
| Table | Create Table
+-------+-----------------------------------------------------------+
| dept  | CREATE TABLE `dept` (
  `deptno` decimal(2,0) NOT NULL,
  `dept_name` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci |
+-------+-----------------------------------------------------------+

--Ερώτημα 14:
alter table dept
add constraint pk_DEPTNO
primary key (deptno);

MariaDB [personnel]> describe dept;
+-----------+--------------+------+-----+---------+-------+
| Field     | Type         | Null | Key | Default | Extra |
+-----------+--------------+------+-----+---------+-------+
| deptno    | decimal(2,0) | NO   | PRI | NULL    |       |
| dept_name | varchar(25)  | YES  |     | NULL    |       |
+-----------+--------------+------+-----+---------+-------+

alter table job
add constraint pk_JOBCODE
primary key (jobcode);

MariaDB [personnel]> describe job;
+-----------+---------------+------+-----+---------+-------+
| Field     | Type          | Null | Key | Default | Extra |
+-----------+---------------+------+-----+---------+-------+
| jobcode   | decimal(3,0)  | NO   | PRI | NULL    |       |
| job_descr | varchar(30)   | YES  |     | NULL    |       |
| sal       | decimal(10,2) | YES  |     | NULL    |       |
+-----------+---------------+------+-----+---------+-------+

alter table emp
add constraint pk_EMPNO primary key (empno),
add constraint fk_EMP_DEPT foreign key (deptno) references dept(deptno),
add constraint fk_EMP_JOB foreign key (jobno) references job(jobcode);

MariaDB [personnel]> describe emp;
+----------+---------------+------+-----+---------+-------+
| Field    | Type          | Null | Key | Default | Extra |
+----------+---------------+------+-----+---------+-------+
| empno    | decimal(4,0)  | NO   | PRI | NULL    |       |
| name     | varchar(24)   | YES  |     | NULL    |       |
| jobno    | decimal(3,0)  | YES  | MUL | NULL    |       |
| deptno   | decimal(2,0)  | YES  | MUL | NULL    |       |
| comm     | decimal(10,2) | YES  |     | NULL    |       |
| hiredate | date          | YES  |     | NULL    |       |
+----------+---------------+------+-----+---------+-------+

--Ερώτημα 15:
alter table emp
drop foreign key fk_EMP_DEPT;

MariaDB [personnel]> show create table emp;
+-------+---------------------------------------------------------------------+
| Table | Create Table
+-------+-------------------------------------------------------------------+
| emp   | CREATE TABLE `emp` (
  `empno` decimal(4,0) NOT NULL,
  `name` varchar(24) DEFAULT NULL,
  `jobno` decimal(3,0) DEFAULT NULL,
  `deptno` decimal(2,0) DEFAULT NULL,
  `comm` decimal(10,2) DEFAULT NULL,
  `hiredate` date DEFAULT NULL,
  PRIMARY KEY (`empno`),
  KEY `fk_EMP_DEPT` (`deptno`),
  KEY `fk_EMP_JOB` (`jobno`),
  CONSTRAINT `fk_EMP_JOB` FOREIGN KEY (`jobno`) REFERENCES `job` (`jobcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci |
+-------+-------------------------------------------------------------------------------+

alter table emp
drop foreign key fk_EMP_JOB;

MariaDB [personnel]> show create table emp;
+-------+-----------------------------------------------------------------+
| Table | Create Table
+-------+--------------------------------------------------------------+
| emp   | CREATE TABLE `emp` (
  `empno` decimal(4,0) NOT NULL,
  `name` varchar(24) DEFAULT NULL,
  `jobno` decimal(3,0) DEFAULT NULL,
  `deptno` decimal(2,0) DEFAULT NULL,
  `comm` decimal(10,2) DEFAULT NULL,
  `hiredate` date DEFAULT NULL,
  PRIMARY KEY (`empno`),
  KEY `fk_EMP_DEPT` (`deptno`),
  KEY `fk_EMP_JOB` (`jobno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci |
+-------+------------------------------------------------------------------+

--Ερώτημα 16:
--Η στήλη DNAME έχει μετονομαστεί σε DEPT_NAME από προηγούμενο ερώτημα
alter table dept
alter DEPT_NAME set default 'Development';

MariaDB [personnel]> insert into EMP(EMPNO,NAME,JOBNO,DEPTNO,COMM) values (10, 'CODD', 100, 50, NULL);
ERROR 1062 (23000): Duplicate entry '10' for key 'PRIMARY'

MariaDB [personnel]> insert into DEPT(DEPTNO) values (10), (20);
MariaDB [personnel]> select * from dept;
+--------+-------------+
| deptno | dept_name   |
+--------+-------------+
|     10 | Development |
|     20 | Development |
|     50 | SALES       |
|     60 | ACCOUNTING  |
|     70 | PAYROL      |
+--------+-------------+

MariaDB [personnel]> insert into DEPT values (30, 'Sales');
MariaDB [personnel]> select * from dept;
+--------+-------------+
| deptno | dept_name   |
+--------+-------------+
|     10 | Development |
|     20 | Development |
|     30 | Sales       |
|     50 | SALES       |
|     60 | ACCOUNTING  |
|     70 | PAYROL      |
+--------+-------------+

--Ερώτημα 17:
MariaDB [personnel]> select * from information_schema.table_constraints where constraint_schema='personnel';
+--------------------+-------------------+-----------------+--------------+------------+-----------------+
| CONSTRAINT_CATALOG | CONSTRAINT_SCHEMA | CONSTRAINT_NAME | TABLE_SCHEMA | TABLE_NAME | CONSTRAINT_TYPE |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+
| def                | personnel         | PRIMARY         | personnel    | dept       | PRIMARY KEY     |
| def                | personnel         | PRIMARY         | personnel    | emp        | PRIMARY KEY     |
| def                | personnel         | PRIMARY         | personnel    | job        | PRIMARY KEY     |
+--------------------+-------------------+-----------------+--------------+------------+-----------------+

--Ερώτημα 18:
create table project(
p_id int not null auto_increment,
p_name varchar(255),
primary key (p_id));

MariaDB [personnel]> describe project;
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| p_id   | int(11)      | NO   | PRI | NULL    | auto_increment |
| p_name | varchar(255) | YES  |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+

--Ερώτημα 19:
insert into project (p_name) values
('project 1'),
('project 2');

MariaDB [personnel]> select * from project;
+------+-----------+
| p_id | p_name    |
+------+-----------+
|    1 | project 1 |
|    2 | project 2 |
+------+-----------+

--Ερώτημα 20:
alter table project auto_increment=200;

insert into project (p_name) values('project 3');

MariaDB [personnel]> select * from project;
+------+-----------+
| p_id | p_name    |
+------+-----------+
|    1 | project 1 |
|    2 | project 2 |
|  200 | project 3 |
+------+-----------+
