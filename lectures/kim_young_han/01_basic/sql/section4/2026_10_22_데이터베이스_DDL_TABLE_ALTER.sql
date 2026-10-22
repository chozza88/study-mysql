-- DDL - 테이블 변경, 제거 
-- ALTER TABLE: 이미 만든 테이블의 구조 변경 
-- 쇼핑몰을 한창 운영하다 보면, 이미 만들어 둔 테이블의 구조를 변경해야 할 때가 생긴다. 예를 들어, 고객에게 포인트를 지급하는 제도
-- 를 새로 도입해서 customers 테이블에 point 열을 추가해야 할 수 있다. 이럴 때 사용하는 것이 ALTER TABLE 명령어다. 

USE my_shop;

-- 열(속성) 추가
ALTER TABLE customers
ADD COLUMN point INT NOT NULL DEFAULT 0;

-- 열(속성) 변경
ALTER TABLE customers
MODIFY COLUMN address VARCHAR(500) NOT NULL;

-- 열(속성) 삭제 
ALTER TABLE customers
DROP COLUMN point; 

DESC customers;

SELECT * FROM customers;

-- 왜래 키 체크 비 활성화
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE products;

-- 왜래 키 체크 활성화
SET FOREIGN_KEY_CHECKS = 1;

