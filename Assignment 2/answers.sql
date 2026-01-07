--1)

SELECT 
ENAME,
CONCAT(FORMAT(SAL, 0), ' €') AS 'ΜΙΣΘΟΣ',
IFNULL(COMM, 0) AS 'ΠΡΟΜΗΘΕΙΑ',
CONCAT(FORMAT(IFNULL(COMM, 0) / SAL * 100, 2), ' %') AS 'ΠΟΣΟΣΤΟ'
FROM EMP;

+---------+---------+-----------+---------+
| ENAME   | ΜΙΣΘΟΣ  | ΠΡΟΜΗΘΕΙΑ | ΠΟΣΟΣΤΟ |
+---------+---------+-----------+---------+
| CODD    | 3,000 € |         0 | 0.00 %  |
| ELMASRI | 1,200 € |       150 | 12.50 % |
| NAVATHE | 2,000 € |         0 | 0.00 %  |
| DATE    | 1,800 € |       200 | 11.11 % |
+---------+---------+-----------+---------+

--2)

SELECT
ENAME AS 'ΕΠΩΝΥΜΟ',
CONCAT(FORMAT(SAL, 0), ' €') AS 'ΜΗΝΙΑΙΕΣ ΑΠΟΔΟΧΕΣ',
CONCAT(TIMESTAMPDIFF(YEAR, HIREDATE, CURDATE()), ' έτη') AS 'ΠΡΟΫΠΗΡΕΣΙΑ'
FROM EMP
WHERE TIMESTAMPDIFF(YEAR, HIREDATE, CURDATE())> 20;

+---------+-------------------+-------------+
| ΕΠΩΝΥΜΟ | ΜΗΝΙΑΙΕΣ ΑΠΟΔΟΧΕΣ | ΠΡΟΫΠΗΡΕΣΙΑ |
+---------+-------------------+-------------+
| CODD    | 3,000 €           | 36 έτη       |
| ELMASRI | 1,200 €           | 30 έτη       |
| NAVATHE | 2,000 €           | 47 έτη       |
| DATE    | 1,800 €           | 21 έτη       |
+---------+-------------------+-------------+

--3)

SELECT
ENAME AS 'ΕΠΩΝΥΜΟ',
JOB AS 'ΘΕΣΗ',
HIREDATE AS 'ΠΡΟΣΛΗΨΗ'
FROM EMP
WHERE
JOB IN ('ANALYST', 'SALESMAN')
AND DAY(HIREDATE) BETWEEN 1 AND 5;

+---------+---------+------------+
| ΕΠΩΝΥΜΟ | ΘΕΣΗ    | ΠΡΟΣΛΗΨΗ   |
+---------+---------+------------+
| CODD    | ANALYST | 1989-01-01 |
| ELMASRI | ANALYST | 1995-05-02 |
+---------+---------+------------+

--4)

SELECT ENAME FROM EMP
WHERE JOB IN(
SELECT JOB FROM EMP WHERE DEPTNO= 10)
AND DEPTNO <> 10;

Empty set (0.001 sec) --Κανένας

Εδώ φιλτράρω εκτός τους υπαλλήλους που ανήκουν στο ACCOUNTING
γιατί ψάχνουμε υπαλλήλους άλλων τμημάτων που εργάζονται στην ίδια
θέση με κάποιον από το ACCOUNTING.

--5)

SELECT
ENAME,
(SAL+ IFNULL(COMM, 0)) AS 'ΣΥΝΟΛΙΚΕΣ ΑΠΟΔΟΧΕΣ'
FROM EMP
WHERE(SAL+ IFNULL(COMM, 0))= (
SELECT MAX(SAL+ IFNULL(COMM, 0))
FROM EMP AS MEG
WHERE MEG.DEPTNO= EMP.DEPTNO);

+---------+--------------------+
| ENAME   | ΣΥΝΟΛΙΚΕΣ ΑΠΟΔΟΧΕΣ |
+---------+--------------------+
| CODD    |               3000 |
| NAVATHE |               2000 |
+---------+--------------------+

--6)

SELECT ENAME, SAL
FROM EMP
WHERE DEPTNO= 10
AND SAL< (SELECT MAX(SAL)
FROM EMP WHERE DEPTNO= 20);

+---------+------+
| ENAME   | SAL  |
+---------+------+
| ELMASRI | 1200 |
| DATE    | 1800 |
+---------+------+
