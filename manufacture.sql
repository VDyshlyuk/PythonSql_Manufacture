CREATE DATABASE manufacture;

USE manufacture; ALTER DATABASE manufacture CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE price (
part_number VARCHAR(10) NOT NULL PRIMARY KEY,
price DECIMAL(10,2) NOT NULL
);
CREATE TABLE deposit (
part_number VARCHAR(10) NOT NULL PRIMARY KEY,
deposit DECIMAL(10,2) NOT NULL
);
CREATE TABLE weight (
part_number VARCHAR(10) NOT NULL PRIMARY KEY,
weight_unpacked  DECIMAL(7,4),
weight_packed DECIMAL(7,4)
);
CREATE TABLE quantity (
part_number VARCHAR(10) NOT NULL,
quantity VARCHAR(3) NOT NULL, 
warehouse VARCHAR(3) NOT NULL,
PRIMARY KEY (part_number,warehouse) 
);
CREATE TABLE product (
part_number VARCHAR(10) NOT NULL,
manufacturer VARCHAR(50) NOT NULL,
main_part_number VARCHAR(50) NOT NULL,
category VARCHAR(100) NOT NULL,
origin VARCHAR(5) NOT NULL
);

SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/weight.txt' INTO TABLE weight;
SELECT * FROM weight;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/price.csv' INTO TABLE price
FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES (part_number,@pr)
SET price = REPLACE(@pr, ',', '.');
SELECT * FROM price;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/deposit.csv' INTO TABLE deposit
FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 LINES (part_number,@dp)
SET deposit = REPLACE(@dp, ',', '.');
SELECT * FROM deposit;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/quantity.csv' INTO TABLE quantity
FIELDS TERMINATED BY ';' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;
SELECT * FROM quantity;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data.csv' INTO TABLE product
FIELDS TERMINATED BY ';' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;
SELECT * FROM product;

ALTER TABLE product ADD COLUMN data_id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;
SELECT * FROM product;

SELECT 'main_part_number', 'manufacturer', 'category', 'origin', 'quantity', 'price', 'deposit', 'total_price'
UNION ALL
SELECT * from (SELECT product.main_part_number, product.manufacturer, product.category, product.origin, CAST(REPLACE(quantity.quantity, '>', '') AS UNSIGNED) AS quantity, price.price,
IFNULL(deposit.deposit,0) AS deposit, (price.price + IFNULL(deposit.deposit,0)) AS total_price
FROM product
LEFT JOIN price ON product.part_number = price.part_number 
LEFT JOIN deposit ON product.part_number = deposit.part_number 
LEFT JOIN quantity ON product.part_number = quantity.part_number 
WHERE quantity.warehouse IN ('A', 'H', 'J', '3', '9') AND (quantity.quantity != '0') AND ((price.price + IFNULL(deposit.deposit,0)) >= 2.00)
ORDER BY quantity.warehouse) resulting_set
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/rezults_VictoriaDyshlyuk.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"'
LINES TERMINATED BY '\n';