show databases;
USE my_shop;
show tables;

-- create문 
INSERT INTO sample (product_id, name, price, stock_quantity, release_date)
VALUES (1, '프리미엄 청바지', 59900, 100, '2025-06-11');

-- read문
SELECT * FROM sample;

-- update문
UPDATE sample 
SET price = 40000
WHERE product_id = 1;

-- delete문
DELETE FROM sample
WHERE product_id = 1;

