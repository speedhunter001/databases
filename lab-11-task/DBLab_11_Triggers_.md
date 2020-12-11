MariaDB [(none)]> create database fb;
Query OK, 1 row affected (0.006 sec)

MariaDB [(none)]> use fb;
Database changed
MariaDB [fb]> CREATE TABLE `blog` (
    -> `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
    -> `title` text,
    -> `content` text,
    -> `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
    -> PRIMARY KEY (`id`),
    -> KEY `ix_deleted` (`deleted`)
    -> );
Query OK, 0 rows affected (0.197 sec)

MariaDB [fb]> CREATE TABLE `audit` (
    -> `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
    -> `blog_id` mediumint(8) unsigned NOT NULL,
    -> `changetype` enum('NEW','EDIT','DELETE') NOT NULL,
    -> `changetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -> PRIMARY KEY (`id`),
    -> KEY `ix_blog_id` (`blog_id`),
    -> KEY `ix_changetype` (`changetype`),
    -> KEY `ix_changetime` (`changetime`),
    -> CONSTRAINT `FK_audit_blog_id` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
    -> );
Query OK, 0 rows affected (0.194 sec)

MariaDB [fb]> show tables;
+--------------+
| Tables_in_fb |
+--------------+
| audit        |
| blog         |
+--------------+
2 rows in set (0.002 sec)

MariaDB [fb]> DELIMITER $$
MariaDB [fb]> CREATE TRIGGER `blog_after_insert` AFTER INSERT
    -> ON fb.`blog`
    -> FOR EACH ROW BEGIN
    -> IF NEW.deleted THEN
    -> SET @changetype = 'DELETE';
    -> ELSE
    -> SET @changetype = 'NEW';
    -> END IF;
    -> 
    -> INSERT INTO audit (blog_id, changetype) VALUES (NEW.id, @changetype);
    -> END  $$
Query OK, 0 rows affected (0.227 sec)

MariaDB [fb]> INSERT INTO blog (title, content) VALUES ('Article One', 'Initial text.');
    -> $$
Query OK, 1 row affected (0.005 sec)

MariaDB [fb]> delimiter ;
MariaDB [fb]> select * from blog;
+----+-------------+---------------+---------+
| id | title       | content       | deleted |
+----+-------------+---------------+---------+
|  1 | Article One | Initial text. |       0 |
+----+-------------+---------------+---------+
1 row in set (0.001 sec)

MariaDB [fb]> select * from audit;
+----+---------+------------+---------------------+
| id | blog_id | changetype | changetime          |
+----+---------+------------+---------------------+
|  1 |       1 | NEW        | 2020-04-09 14:59:26 |
+----+---------+------------+---------------------+
1 row in set (0.001 sec)

MariaDB [fb]> INSERT INTO blog (title, content) VALUES ('Article One', 'change text.');
Query OK, 1 row affected (0.001 sec)

MariaDB [fb]> select * from blog;
+----+-------------+---------------+---------+
| id | title       | content       | deleted |
+----+-------------+---------------+---------+
|  1 | Article One | Initial text. |       0 |
|  2 | Article One | change text.  |       0 |
+----+-------------+---------------+---------+
2 rows in set (0.001 sec)

MariaDB [fb]> select * from blog;
+----+-------------+---------------+---------+
| id | title       | content       | deleted |
+----+-------------+---------------+---------+
|  1 | Article One | Initial text. |       0 |
|  2 | Article One | change text.  |       0 |
+----+-------------+---------------+---------+
2 rows in set (0.001 sec)

MariaDB [fb]> UPDATE blog SET content = 'Edited text' WHERE id = 1;
Query OK, 1 row affected (0.001 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [fb]> select * from blog;
+----+-------------+--------------+---------+
| id | title       | content      | deleted |
+----+-------------+--------------+---------+
|  1 | Article One | Edited text  |       0 |
|  2 | Article One | change text. |       0 |
+----+-------------+--------------+---------+
2 rows in set (0.001 sec)

MariaDB [fb]> select * from audit;
+----+---------+------------+---------------------+
| id | blog_id | changetype | changetime          |
+----+---------+------------+---------------------+
|  1 |       1 | NEW        | 2020-04-09 14:59:26 |
|  2 |       2 | NEW        | 2020-04-09 14:59:57 |
+----+---------+------------+---------------------+
2 rows in set (0.001 sec)

MariaDB [fb]> DELIMITER $$
MariaDB [fb]> 
MariaDB [fb]> CREATE
    -> TRIGGER `blog_after_update` AFTER UPDATE
    -> ON fb.`blog`
    -> FOR EACH ROW BEGIN
    -> IF NEW.deleted THEN
    -> SET @changetype = 'DELETE';
    -> ELSE
    -> SET @changetype = 'EDIT';
    -> END IF;
    -> 
    -> INSERT INTO audit (blog_id, changetype) VALUES (NEW.id, @changetype);
    -> END $$
Query OK, 0 rows affected (0.228 sec)

MariaDB [fb]> 
MariaDB [fb]> DELIMITER ;
MariaDB [fb]> UPDATE blog SET content = 'Edited text' WHERE id = 1;
Query OK, 0 rows affected (0.004 sec)
Rows matched: 1  Changed: 0  Warnings: 0

MariaDB [fb]> select * from blog;
+----+-------------+--------------+---------+
| id | title       | content      | deleted |
+----+-------------+--------------+---------+
|  1 | Article One | Edited text  |       0 |
|  2 | Article One | change text. |       0 |
+----+-------------+--------------+---------+
2 rows in set (0.001 sec)

MariaDB [fb]> select * from audit;
+----+---------+------------+---------------------+
| id | blog_id | changetype | changetime          |
+----+---------+------------+---------------------+
|  1 |       1 | NEW        | 2020-04-09 14:59:26 |
|  2 |       2 | NEW        | 2020-04-09 14:59:57 |
|  3 |       1 | EDIT       | 2020-04-09 15:01:08 |
+----+---------+------------+---------------------+
3 rows in set (0.000 sec)

MariaDB [fb]> UPDATE blog SET deleted = 1 WHERE id = 1;
Query OK, 1 row affected (0.002 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [fb]> select * from blog;
+----+-------------+--------------+---------+
| id | title       | content      | deleted |
+----+-------------+--------------+---------+
|  1 | Article One | Edited text  |       1 |
|  2 | Article One | change text. |       0 |
+----+-------------+--------------+---------+
2 rows in set (0.001 sec)

MariaDB [fb]> select * from audit;
+----+---------+------------+---------------------+
| id | blog_id | changetype | changetime          |
+----+---------+------------+---------------------+
|  1 |       1 | NEW        | 2020-04-09 14:59:26 |
|  2 |       2 | NEW        | 2020-04-09 14:59:57 |
|  3 |       1 | EDIT       | 2020-04-09 15:01:08 |
|  4 |       1 | DELETE     | 2020-04-09 15:01:36 |
+----+---------+------------+---------------------+
4 rows in set (0.001 sec)

MariaDB [fb]> exit;
