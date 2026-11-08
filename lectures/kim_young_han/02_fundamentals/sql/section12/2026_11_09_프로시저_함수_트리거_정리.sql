use my_shop2;

-- 프로시저, 함수, 트리거

drop table if exists logs;

create table logs (
	id int auto_increment primary key
    , description varchar(255)
    , create_at datetime default current_timestamp
);

-- 구분자를 // 로 변경
delimiter // 

create procedure sp_change_user_address(
	in user_id_param int
    , in new_address_param varchar(255)
)
begin
	-- 1. users 테이블의 주소 업데이트 
    update users 
    set address = new_address_param 
    where user_id = user_id_param; 
    
    -- 2. logs 테이블에 변경 이력 기록 
    insert into logs (description)
    values (concat('User ID ', user_id_param, ' 주소 변경 ', new_address_param));
end //

-- 구분자를 다시 ; 로 원상 복구 
delimiter ;

select * from users
where user_id = 2;

call sp_change_user_address(2, '경기도 성남시2');

select * from logs;

-- 프로시저 삭제 (DROP PROCEDURE)
drop procedure if exists sp_change_user_address;

-- 함수 
drop table if exists stored_items;

create table stored_items (
	item_id bigint auto_increment primary key
    , name varchar(255) not null
    , price int not null
    , discount_rate decimal(5, 2)
);

insert into stored_items (name, price, discount_rate) values
('고성능 노트북', 150000, 10.00)
, ('무선 마우스', 25000, 20.00)
, ('기계식 키보드', 120000, 30.00)
, ('4K 모니터', 450000, 40.00)
, ('전동 높이조절 책상', 800000, 50.00);

select
	name
	, price
    , discount_rate
    , fn_get_final_price(price, discount_rate) as final_price
from stored_items;

delimiter //

create function fn_get_final_price(
	price_param int
    , discount_rate_param decimal(5, 2)
)
returns decimal(10, 2)
deterministic
begin
	-- 최종 가격을 계산 (가격 * (1 - 할인율/100))
    return price_param * (1 - discount_rate_param / 100);
end //

delimiter ;

-- 함수 삭제 
drop function if exists fn_get_final_price;


-- 트리거
-- 실습을 위한 탈퇴 고객 테이블 생성 
drop table if exists retired_users;
create table retired_users (
	id bigint primary key
    , name varchar(255) not null
    , email varchar(255) not null
    , retired_date date not null
); 

-- 탈퇴 고객 데이터 입력 
insert into retired_users (id, name, email, retired_date) values 
(1, '션', 'sean@example.com', '2024-12-31')
, (7, '아이작 뉴턴', 'newton@example.com', '2025-01-10');

delimiter //

create trigger trg_backup_user
before delete on users
for each row
begin
	insert into retired_users (id, name, email, retired_date)
    values (OLD.user_id, OLD.name, OLD.email, curdate());
end //

delimiter ;

select * from users
where user_id = 5;

delete from users
where user_id = 5;

select * from retired_users;

