DROP DATABASE IF EXISTS homework4;
CREATE DATABASE IF NOT EXISTS homework4;

USE homework4;
DROP TABLE IF EXISTS shops;
DROP TABLE IF EXISTS cats;

CREATE TABLE IF NOT EXISTS shops (
	id INT PRIMARY KEY,
    shopname VARCHAR (100)
);

TRUNCATE TABLE shops;

INSERT INTO shops
VALUES 
		(1, "Четыре лапы"),
        (2, "Мистер Зоо"),
        (3, "МурзиЛЛа"),
        (4, "Кошки и собаки");
        

CREATE TABLE IF NOT EXISTS cats (
	name VARCHAR (100),
    id INT PRIMARY KEY,
    shops_id INT,
    FOREIGN KEY (shops_id) REFERENCES shops(id) ON UPDATE CASCADE
);

TRUNCATE TABLE cats;

INSERT INTO cats
VALUES 
		("Murzik",1,1),
        ("Nemo",2,2),
        ("Vicont",3,1),
        ("Zuza",4,3);
        
# Task 1
SELECT c.*, s.*
FROM cats c
JOIN shops s
ON c.shops_id = s.id;

#Task2
SELECT s.*
FROM shops s
JOIN cats c 
ON c.shops_id = s.id
WHERE c.name = "Murzik";

#Task3
SELECT s.*
FROM shops s
WHERE s.id NOT IN 
	(
		SELECT c.shops_id 
		FROM cats c 
		JOIN shops s 
		ON c.shops_id = s.id
		WHERE (c.name = "Murzik") OR (c.name = "Zuza")
    );

# ------------------------------------------------------------------------------------------------------------
# Второе задание
# Там в таблице GroupsAn, по-моему, ошибка (я пометил отдельнвм комментом), но она не влияет на решение вроде как

DROP TABLE IF EXISTS Analysis;

CREATE TABLE Analysis
(
	an_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	an_name varchar(50),
	an_cost INT,
	an_price INT,
	an_group INT
);

TRUNCATE TABLE Analysis;

INSERT INTO Analysis (an_name, an_cost, an_price, an_group)
VALUES 
	('Общий анализ крови', 30, 50, 1),
	('Биохимия крови', 150, 210, 1),
	('Анализ крови на глюкозу', 110, 130, 1),
	('Общий анализ мочи', 25, 40, 2),
	('Общий анализ кала', 35, 50, 2),
	('Общий анализ мочи', 25, 40, 2),
	('Тест на COVID-19', 160, 210, 3);

DROP TABLE IF EXISTS GroupsAn;

CREATE TABLE GroupsAn
(
	gr_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	gr_name varchar(50),
	gr_temp FLOAT(5,1),
	FOREIGN KEY (gr_id) REFERENCES Analysis (an_id)   # Вот здесь, по-моему, должно быть ... REFERENCES Analysis (an_group)
	ON DELETE CASCADE ON UPDATE CASCADE
);

TRUNCATE TABLE GroupsAn;

INSERT INTO GroupsAn (gr_name, gr_temp)
VALUES 
	('Анализы крови', -12.2),
	('Общие анализы', -20.0),
	('ПЦР-диагностика', -20.5);


DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders
(
	ord_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	ord_datetime DATETIME,	-- 'YYYY-MM-DD hh:mm:ss'
	ord_an INT,
	FOREIGN KEY (ord_an) REFERENCES Analysis (an_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

TRUNCATE TABLE Orders;

INSERT INTO Orders (ord_datetime, ord_an)
VALUES 
	('2020-02-04 07:15:25', 1),
	('2020-02-04 07:20:50', 2),
	('2020-02-04 07:30:04', 1),
	('2020-02-04 07:40:57', 1),
	('2020-02-05 07:05:14', 1),
	('2020-02-05 07:15:15', 3),
	('2020-02-05 07:30:49', 3),
	('2020-02-06 07:10:10', 2),
	('2020-02-06 07:20:38', 2),
	('2020-02-07 07:05:09', 1),
	('2020-02-07 07:10:54', 1),
	('2020-02-07 07:15:25', 1),
	('2020-02-08 07:05:44', 1),
	('2020-02-08 07:10:39', 2),
	('2020-02-08 07:20:36', 1),
	('2020-02-08 07:25:26', 3),
	('2020-02-09 07:05:06', 1),
	('2020-02-09 07:10:34', 1),
	('2020-02-09 07:20:19', 2),
	('2020-02-10 07:05:55', 3),
	('2020-02-10 07:15:08', 3),
	('2020-02-10 07:25:07', 1),
	('2020-02-11 07:05:33', 1),
	('2020-02-11 07:10:32', 2),
	('2020-02-11 07:20:17', 3),
	('2020-02-12 07:05:36', 1),
	('2020-02-12 07:10:54', 2),
	('2020-02-12 07:20:19', 3),
	('2020-02-12 07:35:38', 1);

#Task1
SELECT an.an_id, an.an_name, ord.ord_datetime
FROM Analysis an
JOIN Orders ord
ON ord.ord_an = an.an_id
WHERE ord.ord_datetime BETWEEN "2020-02-05 00:00:00" AND "2020-02-12 23:59:59"
ORDER BY ord.ord_datetime;

