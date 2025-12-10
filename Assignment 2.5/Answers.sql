--Ερώτημα 1
# mysql -u root
Welcome to the MariaDB monitor.

--Ερωτήματα 2 & 3
MariaDB [(none)]> create database my_accounts;
Query OK, 1 row affected (0.001 sec)

MariaDB [(none)]> use my_accounts;
Database changed

create table Accounts ( acctID integer not null primary key, Balance integer not null);
insert into Accounts (acctID, Balance) values (101, 1000);
insert into Accounts (acctID, Balance) values (202, 2000);
insert into Accounts (acctID, Balance) values (303, 2500);
insert into Accounts (acctID, Balance) values (404, 3000);

MariaDB [my_accounts]> show tables;
+-----------------------+
| Tables_in_my_accounts |
+-----------------------+
| accounts              |
+-----------------------+

MariaDB [my_accounts]> select * from accounts;
+--------+---------+
| acctID | Balance |
+--------+---------+
|    101 |    1000 |
|    202 |    2000 |
|    303 |    2500 |
|    404 |    3000 |
+--------+---------+

MariaDB [my_accounts]> describe accounts;
+---------+---------+------+-----+---------+-------+
| Field   | Type    | Null | Key | Default | Extra |
+---------+---------+------+-----+---------+-------+
| acctID  | int(11) | NO   | PRI | NULL    |       |
| Balance | int(11) | NO   |     | NULL    |       |
+---------+---------+------+-----+---------+-------+

--Ερώτημα 4
MariaDB [my_accounts]> set @rownum=0;
Query OK, 0 rows affected (0.000 sec)

MariaDB [my_accounts]> select (@rownum:=@rownum+1) as No, acctID, Balance from Accounts order by acctID;
+------+--------+---------+
| No   | acctID | Balance |
+------+--------+---------+
|    1 |    101 |    1000 |
|    2 |    202 |    2000 |
|    3 |    303 |    2500 |
|    4 |    404 |    3000 |
+------+--------+---------+

--Ερώτημα 5
Όχι, η αύξουσα αρίθμηση δεν θα πρέπει να υπάρχει και στον πίνακα Accounts γιατί αποτελεί απλώς τρόπο εμφάνισης
του αποτελέσματος ενός ερωτήματος, και δεν αποτελεί χαρακτηριστικό των δεδομένων.

--Ερώτημα 6
MariaDB [my_accounts]> create table customers(
    -> custno integer,
    -> cust_name varchar(30));
Query OK, 0 rows affected (0.005 sec)

MariaDB [my_accounts]> insert into customers values(10, '101');
Query OK, 1 row affected (0.005 sec)

MariaDB [my_accounts]> insert into customers values(20, '202');
Query OK, 1 row affected (0.002 sec)

MariaDB [my_accounts]> show tables;
+-----------------------+
| Tables_in_my_accounts |
+-----------------------+
| accounts              |
| customers             |
+-----------------------+

MariaDB [my_accounts]> select * from customers;
+--------+-----------+
| custno | cust_name |
+--------+-----------+
|     10 | 101       |
|     20 | 202       |
+--------+-----------+

MariaDB [my_accounts]> describe customers;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| custno    | int(11)     | YES  |     | NULL    |       |
| cust_name | varchar(30) | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+

--Ερώτημα 7
MariaDB [my_accounts]> alter table accounts
    -> add column custno integer;
Query OK, 0 rows affected (0.011 sec)

-Προσθήκη Primary Key στον πίνακα customers:

MariaDB [my_accounts]> alter table customers
    -> modify custno int not null;
Query OK, 0 rows affected (0.026 sec)

MariaDB [my_accounts]> alter table customers
    -> add constraint pk_Customers
    -> primary key (custno);
Query OK, 0 rows affected, 1 warning (0.023 sec)

-Προσθήκη ζητούμενου foreign key:

MariaDB [my_accounts]> alter table accounts
    -> add constraint fk_Accounts_Customers
    -> foreign key (custno)
    -> references customers(custno);
Query OK, 4 rows affected (0.032 sec)

-Ζητούμενες ενημερώσεις:

MariaDB [my_accounts]> update accounts
    -> set custno= 20
    -> where acctid= 202;
Query OK, 1 row affected (0.005 sec)

MariaDB [my_accounts]> update accounts
    -> set custno= 10
    -> where acctid <> 202;
Query OK, 3 rows affected (0.002 sec)

MariaDB [my_accounts]> select * from accounts;
+--------+---------+--------+
| acctID | Balance | custno |
+--------+---------+--------+
|    101 |    1000 |     10 |
|    202 |    2000 |     20 |
|    303 |    2500 |     10 |
|    404 |    3000 |     10 |
+--------+---------+--------+

MariaDB [my_accounts]> describe accounts;
+---------+---------+------+-----+---------+-------+
| Field   | Type    | Null | Key | Default | Extra |
+---------+---------+------+-----+---------+-------+
| acctID  | int(11) | NO   | PRI | NULL    |       |
| Balance | int(11) | NO   |     | NULL    |       |
| custno  | int(11) | YES  | MUL | NULL    |       |
+---------+---------+------+-----+---------+-------+

--Ερώτημα 8
MariaDB [my_accounts]> select CUSTNO, count(*), sum(Balance)
    -> from Accounts
    -> where CUSTNO not in (20)
    -> group by CUSTNO;
+--------+----------+--------------+
| CUSTNO | count(*) | sum(Balance) |
+--------+----------+--------------+
|     10 |        3 |         6500 |
+--------+----------+--------------+

-Παραλλαγή:
MariaDB [my_accounts]> set @CUST_NO=20;
Query OK, 0 rows affected (0.002 sec)

MariaDB [my_accounts]> select CUSTNO, count(*), sum(Balance)
    -> from Accounts
    -> where CUSTNO not in (@CUST_NO)
    -> group by CUSTNO;
+--------+----------+--------------+
| CUSTNO | count(*) | sum(Balance) |
+--------+----------+--------------+
|     10 |        3 |         6500 |
+--------+----------+--------------+

-Ερμηνεία:
Και οι δύο εντολές εμφανίζουν για όλους τους πελάτες εκτός του πελάτη με κωδικό 20,
το πλήθος των λογαριασμών τους και το συνολικό υπόλοιπο τους. Η παραλλαγή υλοποιεί την ίδια
λειτουργία με τη χρήση μεταβλητής.

--Ερώτημα 9
MariaDB [my_accounts]> select count(*), sum(Balance) from Accounts;
+----------+--------------+
| count(*) | sum(Balance) |
+----------+--------------+
|        4 |         8500 |
+----------+--------------+

-Παραλλαγή:
MariaDB [my_accounts]> set @COUNT_acctID=0, @SUM_acctID=0, @AVG_acctID=0;
Query OK, 0 rows affected (0.000 sec)

MariaDB [my_accounts]> select count(*), sum(Balance), avg(Balance)
    -> into @COUNT_acctID, @SUM_acctID, @AVG_acctID
    -> from Accounts;
Query OK, 1 row affected (0.001 sec)

MariaDB [my_accounts]> select @COUNT_acctID, @SUM_acctID, @AVG_acctID, @MY_AVG := @SUM_acctID/@COUNT_acctID;
+---------------+-------------+----------------+--------------------------------------+
| @COUNT_acctID | @SUM_acctID | @AVG_acctID    | @MY_AVG := @SUM_acctID/@COUNT_acctID |
+---------------+-------------+----------------+--------------------------------------+
|             4 |        8500 | 2125.000000000 |                       2125.000000000 |
+---------------+-------------+----------------+--------------------------------------+

-Ερμηνεία:
Η πρώτη εντολή υπολογίζει και εμφανίζει το συνολικό πλήθος των λογαριασμών και το άθροισμα των υπολοίπων τους.
Η παραλλαγή αποθηκεύει τα ίδια μεγέθη σε μεταβλητές και τις εμφανίζει μαζί με τον μέσο όρο τους, μέσω της συνάρτησης AVG.

--Ερώτημα 10
MariaDB [my_accounts]> alter table accounts
    -> add column amount integer;
Query OK, 0 rows affected (0.005 sec)

MariaDB [my_accounts]> select * from accounts;
+--------+---------+--------+--------+
| acctID | Balance | custno | amount |
+--------+---------+--------+--------+
|    101 |    1000 |     10 |   NULL |
|    202 |    2000 |     20 |   NULL |
|    303 |    2500 |     10 |   NULL |
|    404 |    3000 |     10 |   NULL |
+--------+---------+--------+--------+

MariaDB [my_accounts]> describe accounts;
+---------+---------+------+-----+---------+-------+
| Field   | Type    | Null | Key | Default | Extra |
+---------+---------+------+-----+---------+-------+
| acctID  | int(11) | NO   | PRI | NULL    |       |
| Balance | int(11) | NO   |     | NULL    |       |
| custno  | int(11) | YES  | MUL | NULL    |       |
| amount  | int(11) | YES  |     | NULL    |       |
+---------+---------+------+-----+---------+-------+

--Ερώτημα 11

-Ερμηνεία:
To trigger calc_sum ενεργοποιείται πριν από κάθε εισαγωγή εγγραφής στον πίνακα
Accounts και για κάθε νέα γραμμή, προσθέτει την τιμή της στήλης Amount στην μεταβλητή @SUM.
Έτσι υπολογίζεται δυναμικά το συνολικό άθροισμα των ποσών όλων των εγγραφών που εισάγονται.

--Ερώτημα 12
MariaDB [my_accounts]> select factorial(4);
+--------------+
| factorial(4) |
+--------------+
|           24 |
+--------------+

MariaDB [my_accounts]> select factorial(15);
+---------------+
| factorial(15) |
+---------------+
|    2147483647 |  <- Overflow
+---------------+

--Ερώτημα 13
MariaDB [my_accounts]> call my_procedure_Local_Variables();
+------+------+-------+
| @X   | @Y   | @X*@Y |
+------+------+-------+
|   25 |   10 |   250 |
+------+------+-------+

--Ερώτημα 14
MariaDB [my_accounts]> SELECT * FROM myTrace;
+------+----------------+------------+----------+--------+--------+
| t_no | t_user         | t_date     | t_time   | t_proc | t_what |
+------+----------------+------------+----------+--------+--------+
|    2 | root@localhost | 2025-12-09 | 21:37:08 | myProc | hello2 |
|    4 | root@localhost | 2025-12-09 | 21:37:46 | myProc | hello4 |
|    6 | root@localhost | 2025-12-09 | 21:38:00 | myProc | hello6 |
+------+----------------+------------+----------+--------+--------+

--Επεξήγηση:
Η myProc δέχεται έναν ακέραιο αριθμό και ένα string, αντιγράφει το string στην OUT και
καταγράφει στον πίνακα myTrace τα στοιχεία της κλήσης. Εάν ο ακέραιος που εισάγεται
είναι ζυγός, εκτελεί Commit και οι αλλαγές στον myTrace διατηρούνται. Εάν είναι μονός
εκτελεί Rollback και ακυρώνει την εισαγωγή, οπότε τα στοιχεία αυτής της κλήσης δεν καταγράφονται.