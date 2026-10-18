-- 데이터베이스 생성
CREATE DATABASE my_shop;

-- 작업할 데이터베이스 선택하기
-- MySQL 워크벤치를 다시 시작하면 반드시 USE my_shop 명령어를 다시 실행해서 데이터베이스를 선택해야 한다.
USE my_shop;

-- 테이블 설계하고 만들기
CREATE TABLE sample(
	product_id INT PRIMARY KEY
    , name VARCHAR(100)
    , price INT
    , stock_quantity INT
    , release_date DATE
);

-- 테이블 열의 정의가 제대로 만들어졌는지 확인
DESC sample; -- 또는 DESCRIBE sample;

-- 생성된 데이터베이스 확인
SHOW DATABASES;

-- 생성된 데이터베이스에서 테이블 확인
SHOW TABLES;

-- 테이블 삭제
DROP TABLE sample;

-- 데이터베이스 삭제
DROP DATABASE my_shop;

-- 주의: 실제 운영 중인 서비스에서 DROP 명령어, 특히 DROP DATABASE는 절대 함부로 사용해서는 안 된다. 
-- 모든 데이터가 사라지는 돌이킬 수 없는 재앙을 초래할 수 있다. 삭제 전에는 항상 백업이 되어 있는지,
-- 그리고 정말 삭제해야 하는 대상이 맞는지 두 번, 세 번 확인하는 습관을 들여야 한다.