-- 실습을 위해 기존 테이블들을 삭제한다. 
drop table if exists orders;
drop table if exists products;

-- check 제약 조건을 추가하여 products 테이블 재생성 
create table products(
	product_id bigint auto_increment primary key
	, name varchar(255) not null
    , category varchar(100)
    , price int not null check (price >= 0)
    , stock_quantity int not null check (stock_quantity >= 0)
    , discount_rate decimal(5, 2) default 0.00 check (discount_rate between 0.00 and 100.00)
);

