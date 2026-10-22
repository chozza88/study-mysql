-- 문제1
-- 쇼핑몰 프로젝트를 위해 my_test 데이터베이스를 생성하고, 해당 데이터베이스를 사용하도록 선택해라. 
-- 그 후, 고객 정보를 저장할 members 테이블을 생성하라. members 테이블은 다음과 같은 열(column)을 가진다. 
-- id: 정수(INT), 기본키 설정 
-- name: 최대 50글자의 문자열(VARCHAR), NOT NULL 제약 조건 
-- join_date: 날짜(DATE) 

CREATE DATABASE my_test;
USE my_test;

CREATE TABLE members(
	id INT PRIMARY KEY
    , name VARCHAR(50) NOT NULL 
    , join_date DATE
);

DESC members;

-- 문제2 
-- 1번 문제에서 생성한 members 테이블에 아래 두 명의 회원 데이터를 추가하고, 테이블의 전체 내용을 조회해라. 

-- 1. ID: 1, 이름: 션, 가입일: 2025-01-10 
-- 2. ID: 2, 이름: 네이트, 가입일: 2025-02-15 
 
INSERT INTO members (id, name, join_date)
VALUES
(1, '션', '2025-01-10'),
(2, '네이트', '2025-02-15');

SELECT * FROM members;


-- 문제3 
-- 2번 문제에서 추가한 데이터에 다음 두 가지 작업을 수행하고, 최종 결과를 조회해라. 
-- 1. id가 2인 회원 '네이트'의 이름을 '네이트2'로 변경해라. 
-- 2. id가 1인 회원 '션'의 정보를 삭제해라. 

SELECT * FROM members
WHERE id = 2;

UPDATE members
SET name = '네이트2' 
WHERE id = 2;

SELECT * FROM members 
WHERE id = 1;

DELETE FROM members 
WHERE id = 1;

SELECT * FROM members; 

-- 문제4 
-- 쇼핑몰의 products(상품) 테이블을 다음 요구사항과 제약 조건에 맞게 생성하고, 테이블 구조를 확인해라. 
-- (데이터베이스가 my_test로 다르기 때문에 기존 테이블에 영향을 주지 않는다) 
-- product_id: 정수, 자동으로 1씩 증가하는 기본 키(PRIMARY KEY) 
-- product_name: 최대 100글자의 문자열, 비어 있을 수 없음(NOT NULL) 
-- product_code: 최대 20글자의 문자열, 값이 중복 될 수 없음(UNIQUE) 
-- price: 정수, 비어 있을 수 없음(NOT NULL) 
-- stock_count: 정수, 비어 있을 수 없으며(NOT NULL), 값을 지정하지 않으며 기본으로 0이 입력됨(DEFAULT)

CREATE TABLE products(
	product_id INT AUTO_INCREMENT PRIMARY KEY
    , product_name VARCHAR(100) NOT NULL 
    , product_code VARCHAR(20) UNIQUE 
    , price INT NOT NULL 
    , stock_count INT NOT NULL DEFAULT 0
);

DESC products;

-- 문제5 
-- 고객(customers)과 주문(order) 테이블을 생성해라. orders 테이블의 customer_id는 customers 테이블의 
-- customer_id를 참조하는 외래 키(Foreign Key) 관계를 맺어야 한다. 

-- customers 테이블 
-- customer_id: 정수, 기본키, 자동 증가 
-- name: 문자열(50자), 필수 

-- orders 테이블 
-- order_id: 정수, 자동 증가 기본 키 
-- customer_id: 정수, 필수 
-- order_date: 날짜와 시간(DATETIME), 기본값은 현재 시각) 
-- FOREIGN KEY 설정: orders.customer_id가 customers.customer_id를 참조하도록 한다. 

CREATE TABLE customers(
	customer_id INT PRIMARY KEY AUTO_INCREMENT
    , name VARCHAR(50) NOT NULL
);

DESC customers;

CREATE TABLE orders(
	order_id INT PRIMARY KEY AUTO_INCREMENT 
    , customer_id INT NOT NULL 
    , order_date DATETIME DEFAULT CURRENT_TIMESTAMP 
    , CONSTRAINT fk_orders_customers FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers(name)
VALUES ('홍길동');

SELECT * FROM customers;

INSERT INTO orders(customer_id)
VALUES (1);

USE my_shop;
SELECT * FROM orders;
