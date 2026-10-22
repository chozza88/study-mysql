-- 데이터 입력
INSERT INTO customers VALUES (NULL, '강감찬', 'kang@example.com', 'hashed_password_123', '서울시 관악구', '2025-06-11 10:30:00');
INSERT INTO customers VALUES (NULL, '이순신', 'lee@example.com', 'hashed_password_123', '서울시 관악구', '2025-06-11 10:30:00');

select * from customers;

INSERT INTO customers (name, email, password, address) VALUES('세종대왕', 'sejong@example.com', 'hashedd_password_456', '서울시 종로구');

select * from products;

INSERT INTO products (name, price, stock_quantity)
VALUES ('베이직 반팔 티셔츠', 30000, 50);

INSERT INTO products (name, price, stock_quantity) VALUES
('검정 양말', 5000, 100),
('갈색 양말', 5000, 150),
('흰색 양말', 5000, 200);


-- 데이터 수정
UPDATE products
SET price = 9800, stock_quantity = 580
where product_id = 1;

-- 안전 업데이트 확인
SELECT @@SQL_SAFE_UPDATES;

-- 1단계: 변경할 대상을 눈으로 먼저 확인한다.
SELECT * FROM products
WHERE name = '베이직 반팔 티셔츠';
-- 이 상품이 맞는지, 확인완료.

-- 2단계: 확인된 대상에 대해서만 UPDATE를 실행한다.
SET SQL_SAFE_UPDATES = 0; -- 안전 모드 제거alter

UPDATE products
SET price = 990
WHERE name = '베이직 반팔 티셔츠';

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM products;
-- 실무에서는 SQL을 사용해서 데이터를 변경하거나 삭제할 때, 반드시 SELECT 쿼리를 먼저 수행해서 
-- 내가 수정할 데이터를 꼭! 먼저 확인하자. 


-- 데이터 삭제
select * from products
where product_id = 1;

DELETE FROM products
where product_id = 1;

SET FOREIGN_KEY_CHECKS = 0; -- 외래키 제약조건 비활성화
truncate table products;
truncate table customers;
truncate table orders;
SET FOREIGN_KEY_CHECKS = 1; -- 외래키 제약조건 활성화

DESC customers;

-- 제약조건 활용 
-- NOT NULL 제약조건 위반 시 
INSERT INTO customers (email, password, address)
VALUES ('none@eaample', 'password1234', '서울시 없는구');

INSERT INTO customers (name, email, password, address)
VALUES ('강감찬', 'kang@example.com', 'new_password_789', '서울시 강남구');

SELECT * FROM customers;

-- UNIQUE 제약조건 위반 시
INSERT INTO customers (name, email, password, address)
VALUES ('홍길동', 'kang@example.com', 'new_password_123', '서울시 송파구');

INSERT INTO products (name, price, stock_quantity)
VALUES ('베이직 반팔 티셔츠', 19900, 200);

SELECT * FROM products;

-- 참조무결성 제약조건 위반 시
INSERT INTO orders (customer_id, product_id, quantity)
VALUES (999,1,1);

INSERT INTO orders (customer_id, product_id, quantity)
VALUES (1,1,1);

SELECT * FROM orders;

-- 참조무결성 제약조건 위반 시
DELETE FROM products 
WHERE product_id = 1;

DESC orders;
SELECT * FROM orders
WHERE product_id = 1;

DELETE FROM orders
WHERE product_id = 1;

SELECT * FROM products
WHERE product_id = 1;

DELETE FROM products
WHERE product_id = 1;

-- 외래 키 제약조건을 포함한 제약조건들은 INSERT 뿐만 아니라 UPDATE, DELETE 등 모든 상황의 데이터 불일치를 원천 방지한다.
